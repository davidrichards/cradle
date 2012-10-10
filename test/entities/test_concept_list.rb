require_relative '../minitest_helper'
require 'concept_list'

include Cradle

describe ConceptList do
  subject do
    ConceptList.new
  end

  it "takes people" do
    ->{subject << 1}.must_raise ArgumentError
    ->{subject[0] = 1}.must_raise ArgumentError
    assert subject << Concept.new, "Can add concepts"
  end
end
