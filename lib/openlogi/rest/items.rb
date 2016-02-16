require "openlogi/rest/utils"

module Openlogi
  module REST
    module Items
      include Openlogi::REST::Utils

      def get_item(id, stock: false)
        params = stock ? { stock: stock } : {}
        perform_request_with_object(:get, "items/#{id}", params, Openlogi::Item)
      end

      def get_items(stock: false)
        params = stock ? { stock: stock } : {}
        perform_request_with_objects(:get, "items", params, Openlogi::Item)
      end

      def update_item(id, item_params)
        perform_request_with_object(:put, "items/#{id}", item_params, Openlogi::Item)
      end

      def create_item(item_params)
        perform_request_with_object(:post, "items", item_params, Openlogi::Item)
      end

      def destroy_item(id)
        perform_request_with_object(:delete, "items/#{id}", {}, Openlogi::Item)
      end
    end
  end
end
