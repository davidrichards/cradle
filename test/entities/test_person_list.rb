require_relative '../minitest_helper'
require 'person_list'

include Cradle

describe PersonList do
  subject do
    PersonList.new
  end

  it "takes people" do
    ->{subject << 1}.must_raise ArgumentError
    ->{subject[0] = 1}.must_raise ArgumentError
    assert subject << Person.new, "Can add people"
  end
end
