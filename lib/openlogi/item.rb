module Openlogi
  class Item
    attr_accessor :id, :code, :name, :price, :barcode

    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end
  end
end
