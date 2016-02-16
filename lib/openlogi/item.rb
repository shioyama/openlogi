require "openlogi/base_object"

module Openlogi
  class Item < BaseObject
    attr_accessor :id, :code, :name, :price, :barcode
  end
end
