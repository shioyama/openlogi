require "spec_helper"

describe Openlogi::Client do
  let(:access_token) { "accesstoken" }
  let(:client) { Openlogi::Client.new(access_token) }

  shared_examples_for "request with valid headers" do
    it "makes a request with valid headers" do
      do_request

      expect(@request.headers["Authorization"]).to eq("Bearer #{access_token}")
      expect(@request.headers["Accept"]).to eq("application/json")
      expect(@request.headers["X-Api-Version"]).to eq("1.3")
    end
  end

  describe "#get_items" do
    before do
      stub_request(:get, "https://api-demo.openlogi.com/api/items").
        with { |request| @request = request }.
        to_return(body: { "items" => items }.to_json)
    end
    let(:items) { [ { "id": "OS239-I000001", "code": "testcode", "name": "Test Item", "price":123, "barcode": "12345111" } ] }
    let(:do_request) { client.get_items }

    it_behaves_like "request with valid headers"

    it "returns items" do
      items = do_request

      expect(items.size).to eq(1)

      item = items.first
      expect(item.code).to eq("testcode")
      expect(item.name).to eq("Test Item")
      expect(item.price).to eq(123)
      expect(item.barcode).to eq("12345111")
    end
  end

  describe "#create_item" do
    before do
      stub_request(:post, "https://api-demo.openlogi.com/api/items").
        with { |request| @request = request }.
        to_return(body: item.to_json)
    end
    let(:item) do
      {
        "id": "OS239-I000001",
        "code":"testcode",
        "name":"Test Item",
        "price":123,
        "barcode":"12345111"
      }
    end
    let(:do_request) { client.create_item(code: "testcode", name: "Test Item", price: "123", "barcode": "12345111") }

    it_behaves_like "request with valid headers"

    it "returns item" do
      item = do_request

      expect(item.code).to eq("testcode")
      expect(item.name).to eq("Test Item")
      expect(item.price).to eq(123)
      expect(item.barcode).to eq("12345111")
    end
  end

  describe "#endpoint" do
    it "returns test point endpoint when test mode is false" do
      client = Openlogi::Client.new("abc")
      expect(client.endpoint).to eq("https://api-demo.openlogi.com")
    end

    it "returns production endpoint when test mode is true" do
      client = Openlogi::Client.new("abc", test_mode: false)
      expect(client.endpoint).to eq("https://api.openlogi.com")
    end
  end
end
