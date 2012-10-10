require_relative '../minitest_helper'
require 'project'

include Cradle

describe Project do
  subject do
    Project.new
  end
  
  it "is an Entity" do
    Project.ancestors.must_include Entity
  end

end
