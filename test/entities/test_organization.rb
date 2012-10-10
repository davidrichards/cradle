require_relative '../minitest_helper'
require 'organization'

include Cradle

describe Organization do
  subject do
    Organization.new
  end
  
  it "is an Entity" do
    Organization.ancestors.must_include Entity
  end

end
