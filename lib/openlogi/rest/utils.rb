module Openlogi
  module REST
    module Utils
      private

      def perform_request(method, resource, options = {})
        Openlogi::Request.new(self, method, resource, options).perform
      end

      def perform_request_with_object(method, resource, options, klass)
        response = perform_request(method, resource, options)
        klass.new(response)
      end

      def perform_request_with_objects(method, resource, options, klass)
        resource_key = resource.split('/').first
        perform_request(method, resource, options).fetch(resource_key, []).collect do |element|
          klass.new(element)
        end
      end
    end
  end
end
