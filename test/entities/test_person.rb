require_relative '../minitest_helper'
require 'person'

include Cradle

describe Person do
  subject do
    Person.new
  end
  
  it "is an Entity" do
    Person.ancestors.must_include Entity
  end

end
