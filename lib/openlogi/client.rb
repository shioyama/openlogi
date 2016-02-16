module Openlogi
  class Client
    include Openlogi::REST::Items
    include Openlogi::REST::Warehousings
    include Openlogi::REST::Shipments

    attr_reader :access_token, :test_mode

    def initialize(access_token, test_mode: true)
      @access_token = access_token
      @test_mode = test_mode
    end

    def test_mode?
      !!test_mode
    end

    def endpoint
      test_mode? ? "https://api-demo.openlogi.com" : "https://api.openlogi.com"
    end
  end

  class ResponseError < StandardError; end
end
