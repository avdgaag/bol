module Bol
  module Parsers
    class Refinements < Parser
      def xpath
        '*/RefinementGroup'
      end

      def parse_object(el)
        RefinementGroup.new.tap do |category|
          category.name  = el.elements['Name'].text.strip
          category.id    = el.elements['Id'].text.strip
          category.refinements = []
          el.elements.each('Refinement') do |e|
            category.refinements << Refinement.new.tap { |r|
              r.name  = e.elements['Name'].text.strip
              r.id    = e.elements['Id'].text.strip
              r.count = e.elements['ProductCount'].text.strip
            }
          end
        end
      end
    end
  end
end
