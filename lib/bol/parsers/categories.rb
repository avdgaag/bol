module Bol
  module Parsers
    class Categories < Parser
      def xpath
        '*/Category'
      end

      def parse_object(el)
        Category.new.tap do |category|
          category.name  = el.elements['Name'].text.strip
          category.id    = el.elements['Id'].text.strip
          category.count = el.elements['ProductCount'].text.strip.to_i
        end
      end
    end
  end
end
