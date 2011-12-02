module Bol
  module Requests
    class Search < Request
      def initialize(terms, *args)
        @terms = terms
        super *args
      end

      def path
        "/openapi/services/rest/catalog/v3/searchproducts/#{URI.escape(@terms.to_s)}"
      end
    end
  end
end
