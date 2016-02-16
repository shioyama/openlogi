module Openlogi
  class Client
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

    def get_items
      response = Response.new(get_request("items"))

      if response.success?
        response.items
      else
        raise ResponseError
      end
    end

    def create_item(item_params)
      response = Response.new(post_request("items", item_params))

      if response.success?
        response.item
      else
        raise ResponseError
      end
    end

    private

    def get_request(resource)
      make_request(:get, resource)
    end

    def post_request(resource, body)
      make_request(:post, resource, body)
    end

    def make_request(method, resource, body=nil)
      Typhoeus::Request.new(
        URI.join(endpoint, "api/", resource),
        method: method,
        params: nil,
        body: body,
        headers: {
          Accept: "application/json",
          'X-Api-Version': "1.3",
          Authorization: "Bearer #{access_token}"
        }
      ).run
    end
  end

  class ResponseError < StandardError; end
end
