module Openlogi
  class Item
    attr_accessor :id, :code, :name, :price, :barcode

    def initialize(hash)
      @id = hash["id"]
      @code = hash["code"]
      @name = hash["name"]
      @price = hash["price"]
      @barcode = hash["barcode"]
    end
  end
end
