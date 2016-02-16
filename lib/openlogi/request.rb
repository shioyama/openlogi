module Openlogi
  class Request
    attr_reader :client, :method, :resource, :options

    def initialize(client, method, resource, options = nil)
      @client = client
      @method = method
      @resource = resource
      @options = options
    end

    def perform
      options_key = (method == :get ? :params : :body)
      response = Typhoeus::Request.new(
        URI.join(client.endpoint, "api/", resource),
        {
          method: method,
          headers: headers,
        }.merge(options_key => options)
      ).run

      Response.new(response)
    end

    private

    def headers
      {
        Accept: "application/json",
        'X-Api-Version': "1.3",
        Authorization: "Bearer #{client.access_token}"
      }
    end
  end
end
