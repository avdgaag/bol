require 'time'

module Bol
  module Parsers
    class Products < Parser
      def xpath
        '*/Product'
      end

      def parse_object(el)
        Product.new.tap do |product|
          %w[id title subtitle type publisher short_description long_description ean rating binding_description language_code language_description].each do |field|
            _field = camelize(field)
            if el.elements[_field]
              product.attributes[field.to_sym] = el.elements[_field].text.gsub(/\n\s+/, ' ').strip
            end
          end
          product[:url] = el.elements['Urls'].elements['Main'].text.strip
          if el.elements['ReleaseDate']
            product[:release_date] = Time.parse(el.elements['ReleaseDate'].to_s)
          end
          product[:authors] = []
          el.elements.each('Authors/Author') do |author|
            product[:authors] << author.elements['Name'].text
          end
          product[:cover] = {}
          el.elements['Images'].elements.each do |image|
            product[:cover][underscorize(image.name).to_sym] = image.text.strip
          end
        end
      end
    end
  end
end
