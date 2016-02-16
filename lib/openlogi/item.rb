module Openlogi
  class Item
    attr_accessor :id, :code, :name, :price, :barcode

    def initialize(hash)
      hash.each { |k,v| self.public_send("#{k}=", v) }
    end
  end
end
