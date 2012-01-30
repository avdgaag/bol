module Bol
  module Requests
    class List < Request
      def initialize(type, *args)
        @type = type
        super(*args)
      end

      def path
        "/openapi/services/rest/catalog/v3/listresults/#{@type}/#{@query.params[:categoryId]}"
      end

      def proxy
        @proxy ||= begin
          if @query.categories?
            Proxy.new(self, Parsers::Categories.new(self))
          elsif @query.refinements?
            Proxy.new(self, Parsers::Refinements.new(self))
          elsif @query.products?
            super
          end
        end
      end
    end
  end
end
