require 'rexml/document'
require 'ostruct'

module Bol
  class Parser
    attr_reader :request

    def initialize(request)
      @request = request
    end

    def objects
      [].tap do |collection|
        xml.elements.each(xpath) do |el|
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
      @xml ||= REXML::Document.new(request.fetch.body)
    end
  end
end
