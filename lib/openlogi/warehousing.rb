require "openlogi/base_object"

module Openlogi
  class Warehousing < BaseObject
    attr_accessor :items, :tracking_codes, :memo
  end
end
