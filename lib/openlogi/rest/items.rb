require "openlogi/rest/utils"

module Openlogi
  module REST
    module Items
      include Openlogi::REST::Utils

      def get_item(id)
        perform_request_with_objects(:get, "items/#{id}", {}, Openlogi::Item)
      end

      def get_items
        perform_request_with_objects(:get, "items", {}, Openlogi::Item)
      end

      def create_item(item_params)
        perform_request_with_object(:post, "items", item_params, Openlogi::Item)
      end
    end
  end
end
