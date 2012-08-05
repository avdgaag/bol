module Bol
  module Parsers
    class Categories < Parser
      def xpath
        '*/Category'
      end

      def parse_object(el)
        Category.new.tap do |category|
          category.name  = el.at('Name').content.strip
          category.id    = el.at('Id').content.strip
          category.count = el.at('ProductCount').content.strip.to_i
        end
      end
    end
  end
end
