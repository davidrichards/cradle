require_relative '../minitest_helper'
require 'concept'

include Cradle

describe Concept do
  subject do
    Concept.new
  end
  
  it "is an Entity" do
    Concept.ancestors.must_include Entity
  end

end
