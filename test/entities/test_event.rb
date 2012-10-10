require_relative '../minitest_helper'
require 'event'

include Cradle

describe Event do
  subject do
    Event.new
  end
  
  it "is an Entity" do
    Event.ancestors.must_include Entity
  end

end
