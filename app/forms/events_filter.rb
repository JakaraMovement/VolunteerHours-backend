# frozen_string_literal: true

class EventsFilter
  include ActiveModel::Model

  attr_accessor(
    :region
  )

  def initialize(args)
    super(args)
  end
end
