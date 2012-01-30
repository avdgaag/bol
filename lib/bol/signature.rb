require 'base64'

module Bol
  class Signature
    attr_reader :date, :path, :params, :key, :secret

    def initialize(date, path, params)
      @date, @path, @params = date, path, params
      Bol.configuration.validate
      @key    = Bol.configuration[:access_key]
      @secret = Bol.configuration[:secret]
    end

    def generate
      key + ':' + encoded_hash
    end

    private

    def encoded_hash
      Base64.encode64(hash).sub /\n/, ''
    end

    def hash
      OpenSSL::HMAC.digest('sha256', secret, headers)
    end

    def headers
      [
        'GET',
        '',
        'application/xml',
        date,
        "x-openapi-date:#{date}",
        path,
        signature_params
      ].join("\n")
    end

    def signature_params
      params.map { |k, v| "&#{k}=#{v}" }.compact.sort.join("\n")
    end
  end
end
