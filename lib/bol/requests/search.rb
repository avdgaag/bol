module Bol
  module Requests
    class Search < Request
      ignore_params :includeCategories, :includeProducts, :includeRefinements

      def path
        "/openapi/services/rest/catalog/v3/searchresults"
      end
    end
  end
end
