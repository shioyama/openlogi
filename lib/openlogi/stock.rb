require "openlogi/base_object"

module Openlogi
  class Stock < BaseObject
    attr_accessor :available, :shipping, :quantity, :size, :weight
  end
end
