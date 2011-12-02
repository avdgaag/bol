module Bol
  module Requests
    class List < Request
      def initialize(type, *args)
        @type = type
        super *args
      end

      def path
        "/openapi/services/rest/catalog/v3/productlists/#{@type}/#{@query.params[:categoryId]}"
      end
    end
  end
end
