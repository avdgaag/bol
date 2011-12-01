require 'net/https'
require 'base64'
require 'uri'

module Bol
  class Request
    extend Forwardable
    attr_reader :query, :path, :access_key, :secret, :response

    DOMAIN = 'openapi.bol.com'

    def initialize(query, path)
      @query = query
      @path  = path
    end

    def fetch
      uri = URI.parse("https://#{DOMAIN}#{path}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(uri.request_uri)
      request.content_type = 'application/xml'
      request['Connection'] = 'close'
      request['X-OpenAPI-Authorization'] = signature(date)
      request['X-OpenAPI-Date'] = date
      @response = http.request(request)
      self
    end

    def_delegators :response, :code, :body

    def success?
      response.code == '200'
    end

  private

    def date
      @date ||= Time.now.utc.strftime '%a, %d %B %Y %H:%M:%S GMT'
    end

    def signature
      msg =  <<-EOS
GET

application/xml
#{date}
x-openapi-date:#{date}
#{path}
EOS
      access_key + ':' + Base64.encode64(OpenSSL::HMAC.digest('sha256', secret, msg.chomp)).sub(/\n/, '')
    end
  end
end
