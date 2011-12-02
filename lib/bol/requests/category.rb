module Bol
  module Requests
    class Category < Request
      def path
        "/openapi/services/rest/catalog/v3/categorylists/#{@query.params[:categoryId]}"
      end
    end
  end
end
