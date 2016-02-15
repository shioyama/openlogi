module Openlogi
  class Response
    attr_reader :response
    delegate :success?, to: :response

    def initialize(response)
      @response = response
    end

    def items
      json_response["items"].map { |item| Openlogi::Item.new(item) }
    end

    def item
      Openlogi::Item.new(json_response)
    end

    private

    def json_response
      JSON.parse(response.response_body)
    end
  end
end
