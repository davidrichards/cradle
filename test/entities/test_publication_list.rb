require_relative '../minitest_helper'
require 'publication_list'

include Cradle

describe PublicationList do
  subject do
    PublicationList.new
  end

  it "takes people" do
    ->{subject << 1}.must_raise ArgumentError
    ->{subject[0] = 1}.must_raise ArgumentError
    assert subject << Publication.new, "Can add publications"
  end
end
