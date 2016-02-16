require "openlogi/base_object"

module Openlogi
  class Item < BaseObject
    attr_accessor :id, :code, :name, :price, :barcode, :stock, :quantity

    def initialize(options = {})
      super
      @stock = Openlogi::Stock.new(@stock) if @stock
    end
  end
end
