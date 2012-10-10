require_relative '../minitest_helper'
require 'organization_list'

include Cradle

describe OrganizationList do
  subject do
    OrganizationList.new
  end

  it "takes people" do
    ->{subject << 1}.must_raise ArgumentError
    ->{subject[0] = 1}.must_raise ArgumentError
    assert subject << Organization.new, "Can add organizations"
  end
end
