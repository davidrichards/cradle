require_relative '../minitest_helper'
require 'publication'

include Cradle

describe Publication do
  subject do
    Publication.new
  end
  
  it "is an Entity" do
    Publication.ancestors.must_include Entity
  end

end
