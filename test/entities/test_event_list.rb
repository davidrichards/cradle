require_relative '../minitest_helper'
require 'event_list'

include Cradle

describe EventList do
  subject do
    EventList.new
  end

  it "takes people" do
    ->{subject << 1}.must_raise ArgumentError
    ->{subject[0] = 1}.must_raise ArgumentError
    assert subject << Event.new, "Can add events"
  end
end
