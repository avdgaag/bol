module Bol
  module Requests
    class Search < Request
      def path
        "/openapi/services/rest/catalog/v3/searchresults"
      end
    end
  end
end
