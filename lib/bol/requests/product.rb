module Bol
  module Requests
    class Product < Request
      ignore_params :includeCategories, :includeProducts, :includeRefinements

      def initialize(product_id, *args)
        @product_id = product_id
        super *args
      end

      def path
        "/openapi/services/rest/catalog/v3/products/#{URI.escape(@product_id.to_s)}"
      end
    end
  end
end
