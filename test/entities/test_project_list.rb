require_relative '../minitest_helper'
require 'project_list'

include Cradle

describe ProjectList do
  subject do
    ProjectList.new
  end

  it "takes people" do
    ->{subject << 1}.must_raise ArgumentError
    ->{subject[0] = 1}.must_raise ArgumentError
    assert subject << Project.new, "Can add projects"
  end
end
