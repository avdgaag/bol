require 'nokogiri'
require 'ostruct'

module Bol
  class Parser
    attr_reader :request

    def initialize(request)
      @request = request
    end

    def objects
      [].tap do |collection|
        xml.xpath(xpath).each do |el|
          collection << parse_object(el)
        end
      end
    end

  protected

    def underscorize(str)
      str.gsub(/([a-z])([A-Z])/, '\1_\2').downcase
    end

    def camelize(str)
      str.split('_').map(&:capitalize).join('')
    end

    def xml
      body = request.fetch.body
      @xml ||= Nokogiri::XML(body)
    end
  end
end
