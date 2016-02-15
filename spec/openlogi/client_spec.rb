require "spec_helper"

describe Openlogi::Client do
  let(:access_token) { "accesstoken" }
  let(:client) { Openlogi::Client.new(access_token) }

  describe "#get_items" do
    before do
      stub_request(:get, "https://api-demo.openlogi.com/api/items").
        with { |request| @request = request }.
        to_return(body: { "items" => items }.to_json)
    end
    let(:items) { [ { "id": "OS239-I000001", "code": "testcode", "name": "Test Item", "price":123, "barcode": "12345111" } ] }

    it "makes a request with correct parameters" do
      client.get_items

      expect(@request.headers["Authorization"]).to eq("Bearer #{access_token}")
      expect(@request.headers["Accept"]).to eq("application/json")
    end

    it "returns items" do
      items = client.get_items

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

    it "returns item" do
      item = client.create_item(code: "testcode", name: "Test Item", price: "123", "barcode": "12345111")

      expect(item.code).to eq("testcode")
      expect(item.name).to eq("Test Item")
      expect(item.price).to eq(123)
      expect(item.barcode).to eq("12345111")
    end
  end
end
