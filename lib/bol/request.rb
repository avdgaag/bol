require 'forwardable'
require 'net/https'
require 'uri'

module Bol
  class Request
    extend Forwardable

    attr_reader :query, :response, :proxy

    DOMAIN = 'openapi.bol.com'

    def_delegators :@response, :code, :body

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
    end

    def proxy
      @proxy ||= Proxy.new(self, Parsers::Products.new(self))
    end

    def params
      @params ||= query.params.reject do |k, v|
        self.class.ignored_param?(k)
      end
    end

    def query_string
      @query_string ||= params.map { |k, v|
        "#{URI.escape(k.to_s)}=#{URI.escape(v.to_s)}"
      }.join('&')
    end

    def uri
      @uri ||= begin
        uri = if params.empty?
          "https://#{DOMAIN}#{path}"
        else
          "https://#{DOMAIN}#{path}?#{query_string}"
        end
        URI.parse(uri)
      end
    end

    def fetch
      http             = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl     = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request          = Net::HTTP::Get.new(uri.request_uri)
      request.content_type               = 'application/xml'
      request['Connection']              = 'close'
      request['X-OpenAPI-Authorization'] = Signature.new(date, path, params).generate
      request['X-OpenAPI-Date']          = date
      @response = http.request(request)
      raise Bol::Unavailable if @response.code =~ /^5\d\d$/
      raise Bol::NotFound if @response.code =~ /^4\d\d$/
      self
    end

    def success?
      response.code == '200'
    end

  protected

    def date
      @date ||= Time.now.utc.strftime '%a, %d %B %Y %H:%M:%S GMT'
    end

    # overridden in subclasses
    def path
      '/'
    end
  end
end
