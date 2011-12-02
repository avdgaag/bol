require 'rexml/document'
require 'time'

module Bol
  class XmlParser
    def initialize(xml)
      @xml = xml
      @doc = REXML::Document.new(@xml)
    end

    def product
      product = Product.new
      @doc.elements.each('ProductResponse/Product') do |el|
        %w[id title subtitle type publisher short_description long_description ean rating binding_description language_code language_description].each do |field|
          _field = camelize(field)
          product.attributes[field.to_sym] = el.elements[_field].text.gsub /\n\s+/, ' '
        end
        product[:url] = el.elements['Urls'].elements['Main'].text.strip
        product[:release_date] = Time.parse(el.elements['ReleaseDate'].to_s)
        product[:authors] = []
        el.elements.each('Authors/Author') do |author|
          product[:authors] << author.elements['Name'].text
        end
        product[:cover] = {}
        el.elements['Images'].elements.each do |image|
          product[:cover][underscorize(image.name).to_sym] = image.text.strip
        end
      end
      product
    end

  private

    def underscorize(str)
      str.gsub(/([a-z])([A-Z])/, '\1_\2').downcase
    end

    def camelize(str)
      str.split('_').map(&:capitalize).join('')
    end
  end
end
