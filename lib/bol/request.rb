require 'forwardable'
require 'net/https'
require 'base64'
require 'uri'

module Bol
  class Request
    extend Forwardable
    attr_reader :query, :response, :proxy

    DOMAIN             = 'openapi.bol.com'
    ConfigurationError = Class.new(Exception)
    ParameterError     = Class.new(Exception)

    def_delegators :response, :code, :body

    def self.ignore_params(*args)
      @params_to_ignore ||= []
      [*args].each do |arg|
        @params_to_ignore << arg.to_sym
      end
    end

    def self.ignored_param?(name)
      @params_to_ignore ||= []
      @params_to_ignore.include?(name.to_sym)
    end

    def initialize(query)
      @query = query
      @query.request = self
      @proxy = ResultProxy.new(self)
    end

    def params
      @params ||= @query.params.map do |k, v|
        unless self.class.ignored_param?(k)
          "#{URI.escape(k.to_s)}=#{URI.escape(v.to_s)}"
        end
      end.compact.join('&')
    end

    def uri
      uri = if params.empty?
        "https://#{DOMAIN}#{path}"
      else
        "https://#{DOMAIN}#{path}?#{params}"
      end
      @uri ||= URI.parse(uri)
    end

    def fetch
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(uri.request_uri)
      request.content_type = 'application/xml'
      request['Connection'] = 'close'
      request['X-OpenAPI-Authorization'] = signature
      request['X-OpenAPI-Date'] = date
      @response = http.request(request)
      self
    end

    def success?
      response.code == '200'
    end

  protected

    def date
      @date ||= Time.now.utc.strftime '%a, %d %B %Y %H:%M:%S GMT'
    end

    def signature
      raise ConfigurationError unless Bol.configuration[:access_key] and
        Bol.configuration[:secret]
      msg =  <<-EOS
GET

application/xml
#{date}
x-openapi-date:#{date}
#{path}
EOS
      Bol.configuration[:access_key] + ':' + Base64.encode64(OpenSSL::HMAC.digest('sha256', Bol.configuration[:secret], msg.chomp)).sub(/\n/, '')
    end

    # overridden in subclasses
    def path
      '/'
    end
  end
end
