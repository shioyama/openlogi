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
      expect(@request.headers["Content-Type"]).to eq("application/json")
    end
  end

  describe "items endpoint" do
    let(:id) { "OS239-I000001" }
    let(:item) do
      {
        "id": id,
        "code": "testcode",
        "name": "Test Item",
        "price": 123,
        "barcode": "12345111"
      }
    end
    let(:items) { [ item ] }

    describe "#get_item" do
      let!(:stub) do
        stub_request(:get, "https://api-demo.openlogi.com/api/items/#{id}").
          with { |request| @request = request }.to_return(body: item.to_json)
      end
      let(:do_request) { client.get_item(id) }

      it_behaves_like "request with valid headers"

      it "returns item" do
        returned_item = do_request

        expect(stub).to have_been_requested
        expect(returned_item.code).to eq("testcode")
      end

      context "with stock" do
        let(:item) do
          {
            "id": id,
            "code": "testcode",
            "name": "Test Item",
            "stock": {
              "available": 2,
              "shipping": 1,
              "quantity": 3,
              "size": "M",
              "weight": 700
            }
          }
        end

        it "assigns stock" do
          returned_item = do_request

          expect(stub).to have_been_requested

          stock = returned_item.stock
          expect(stock.available).to eq(2)
          expect(stock.shipping).to eq(1)
          expect(stock.quantity).to eq(3)
          expect(stock.size).to eq("M")
          expect(stock.weight).to eq(700)
        end
      end
    end

    describe "#get_items" do
      let!(:stub) do
        stub_request(:get, "https://api-demo.openlogi.com/api/items").
          with { |request| @request = request }.to_return(body: { "items" => items }.to_json)
      end
      let(:do_request) { client.get_items }

      it_behaves_like "request with valid headers"

      it "returns items" do
        returned_items = do_request

        expect(stub).to have_been_requested
        expect(returned_items.size).to eq(1)

        returned_item = returned_items.first
        expect(returned_item.code).to eq("testcode")
        expect(returned_item.name).to eq("Test Item")
        expect(returned_item.price).to eq(123)
        expect(returned_item.barcode).to eq("12345111")
      end

      context "with stock" do
        let(:items) do
          [{
            "id": id,
            "code": "testcode",
            "name": "Test Item",
            "stock": {
              "available": 2,
              "shipping": 1,
              "quantity": 3,
              "size": "M",
              "weight": 700
            }
          }]
        end

        it "assigns stock" do
          returned_items = do_request

          expect(stub).to have_been_requested

          stock = returned_items.first.stock
          expect(stock.available).to eq(2)
          expect(stock.shipping).to eq(1)
          expect(stock.quantity).to eq(3)
          expect(stock.size).to eq("M")
          expect(stock.weight).to eq(700)
        end
      end
    end

    describe "#update_item" do
      let!(:stub) do
        stub_request(:put, "https://api-demo.openlogi.com/api/items/#{id}").
          with { |request| @request = request }.to_return(body: updated_item.to_json)
      end
      let(:updated_item) { item.merge(code: "newcode") }
      let(:do_request) { client.update_item(id, { code: "newcode", name: "Test Item", price: 123 }) }

      it_behaves_like "request with valid headers"

      it "updates item" do
        returned_item = do_request

        expect(stub).to have_been_requested

        expect(@request.body).to eq('{"code":"newcode","name":"Test Item","price":123}')
        expect(returned_item.code).to eq("newcode")
      end
    end

    describe "#create_item" do
      let!(:stub) do
        stub_request(:post, "https://api-demo.openlogi.com/api/items").
          with { |request| @request = request }.to_return(body: item.to_json)
      end
      let(:do_request) { client.create_item(code: "testcode", name: "Test Item", price: 123, "barcode": "12345111") }

      it_behaves_like "request with valid headers"

      it "creates item" do
        returned_item = do_request

        expect(stub).to have_been_requested
        expect(@request.body).to eq('{"code":"testcode","name":"Test Item","price":123,"barcode":"12345111"}')
        expect(returned_item.code).to eq("testcode")
        expect(returned_item.name).to eq("Test Item")
        expect(returned_item.price).to eq(123)
        expect(returned_item.barcode).to eq("12345111")
      end
    end

    describe "#destroy_item" do
      let!(:stub) do
        stub_request(:delete, "https://api-demo.openlogi.com/api/items/#{id}").
          with { |request| @request = request }.to_return(body: item.to_json)
      end
      let(:do_request) { client.destroy_item(id) }

      it_behaves_like "request with valid headers"

      it "deletes item" do
        returned_item = do_request

        expect(stub).to have_been_requested
        expect(returned_item.code).to eq("testcode")
      end
    end
  end

  describe "warehousings endpoint" do
    let(:id) { "AB001-W000" }
    let(:warehousing) do
      {
        "id": id,
        "status": "waiting",
        "memo": "Test memo",
        "tracking_codes": [
          "TrackingCode001",
          "TrackingCode002"
        ],
        "items": [
          {
            "id": "AB001-I00001",
            "code": "DQ001",
            "name": "やくそう",
            "quantity": 20
          }
        ]
      }
    end
    let(:warehousings) { [ warehousing ] }

    describe "#get_warehousings" do
      let!(:stub) do
        stub_request(:get, "https://api-demo.openlogi.com/api/warehousings").
          with { |request| @request = request }.to_return(body: { "warehousings" => warehousings }.to_json)
      end
      let(:do_request) { client.get_warehousings }

      it_behaves_like "request with valid headers"

      it "returns warehousings" do
        returned_warehousings = do_request

        expect(stub).to have_been_requested
        expect(returned_warehousings.size).to eq(1)

        returned_warehousing = returned_warehousings.first
        expect(returned_warehousing.id).to eq(id)
        expect(returned_warehousing.status).to eq("waiting")
        expect(returned_warehousing.memo).to eq("Test memo")
        expect(returned_warehousing.tracking_codes).to eq(["TrackingCode001", "TrackingCode002"])

        items = returned_warehousing.items
        expect(items.count).to eq(1)
        expect(items.first.id).to eq("AB001-I00001")
        expect(items.first.code).to eq("DQ001")
        expect(items.first.name).to eq("やくそう")
        expect(items.first.quantity).to eq(20)
      end
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
