require "openlogi/base_object"

module Openlogi
  class Shipment < BaseObject
    attr_accessor :identifier, :order_no, :recipient, :sender, :items
  end
end
