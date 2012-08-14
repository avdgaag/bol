module Bol
  module Parsers
    class Refinements < Parser
      def xpath
        '*/xmlns:RefinementGroup'
      end

      def parse_object(el)
        RefinementGroup.new.tap do |category|
          category.name  = el.at('Name').content.strip
          category.id    = el.at('Id').content.strip
          category.refinements = []
          el.xpath('xmlns:Refinement').each do |e|
            category.refinements << Refinement.new.tap { |r|
              r.name  = e.at('Name').content.strip
              r.id    = e.at('Id').content.strip
              r.count = e.at('ProductCount').content.strip
            }
          end
        end
      end
    end
  end
end
