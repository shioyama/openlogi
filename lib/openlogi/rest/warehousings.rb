module Openlogi
  module REST
    module Warehousings
      include Openlogi::REST::Utils

      def get_warehousing(id)
        perform_request_with_objects(:get, "warehousings/#{id}", {}, Openlogi::Warehousing)
      end

      def get_warehousings
        perform_request_with_objects(:get, "warehousings", {}, Openlogi::Warehousing)
      end

      def create_warehousing(item_params)
        perform_request_with_object(:post, "warehousings", item_params, Openlogi::Warehousing)
      end
    end
  end
end
