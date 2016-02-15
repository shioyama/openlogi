module Openlogi
  class Client
    attr_reader :access_token

    def initialize(access_token)
      @access_token = access_token
    end

    def endpoint
      "https://api-demo.openlogi.com"
    end

    def get_items
      response = Response.new(get_request("items"))

      if response.success?
        response.items
      else
        raise ResponseError
      end
    end

    private

    def get_request(resource)
      Typhoeus::Request.new(
        URI.join(endpoint, "api/", resource),
        method: :get,
        headers: {
          Accept: "application/json",
          Authorization: "Bearer #{access_token}"
        }
      ).run
    end
  end

  class ResponseError < StandardError; end
end
