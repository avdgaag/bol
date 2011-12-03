module Bol
  module Requests
    class Category < Request
      ignore_params :categoryId, :nrProducts, :offset, :sortingMethod, :sortingAscending

      def path
        "/openapi/services/rest/catalog/v3/categorylists/#{@query.params[:categoryId]}"
      end
    end
  end
end
