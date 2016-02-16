require "openlogi/base_object"

module Openlogi
  class Warehousing < BaseObject
    attr_accessor :id, :items, :tracking_codes, :memo, :status

    def initialize(options = {})
      super
      @items = @items.map { |item| Openlogi::Item.new(item) } if @items
    end
  end
end
