require 'time'

module Bol
  module Parsers
    class Products < Parser
      def xpath
        '*/xmlns:Product'
      end

      def parse_object(el)
        Product.new.tap do |product|
          %w[id title subtitle type publisher short_description long_description ean rating binding_description language_code language_description].each do |field|
            _field = camelize(field)
            if el.at(_field)
              product.attributes[field.to_sym] = el.at(_field).content.gsub(/\n\s+/, ' ').strip
            end
          end

          product[:offers] = []
          el.at('Offers').elements.each do |offer|
            o = %w[id first_edition special_edition state price list_price availability_code availability_description comment second_hand seller].inject({}) do |output, field|
              _field = camelize(field)
              if offer.at(_field)
                output[field] = offer.at(_field).content.gsub(/\n\s+/, ' ').strip
              end
              output
            end
            product[:offers] << OpenStruct.new(o)
          end if el.at('Offers')

          product[:url] = el.at('Urls').at('Main').content.strip
          if el.at('ReleaseDate')
            product[:release_date] = Time.parse(el.at('ReleaseDate').content)
          end
          product[:authors] = []
          el.xpath('xmlns:Authors/xmlns:Author').each do |author|
            product[:authors] << author.at('Name').content
          end
          product[:cover] = {}
          el.xpath('xmlns:Images').children.each do |image|
            product[:cover][underscorize(image.name).to_sym] = image.content.strip
          end
        end
      end
    end
  end
end
