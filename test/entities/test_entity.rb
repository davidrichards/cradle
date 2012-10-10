require_relative '../minitest_helper'
require 'entity'

include Cradle

describe Entity do
  subject do
    Entity.new
  end
  
  it "takes arbitrary attributes" do
    subject.name = "Entity"
    subject.name.must_equal "Entity"
    subject.another = "attribute"
    subject.another.must_equal "attribute"
  end
  
  it "takes arbitrary attributes on initialization" do
    subject = Entity.new(:arbitrary => :attributes)
    subject.arbitrary.must_equal :attributes
  end
  
  it "produces an id, if one hasn't been set" do
    subject.as_json[:id].must_be_nil
    re = /\w{8}\-\w{4}\-\w{4}\-\w{4}\-\w{12}/
    assert subject.id.match(re), "The id uses a UUID, which looks like #{re.inspect}"
  end
  
  describe "associations" do
    it "defaults the associations to a hash" do
      subject.associations.must_equal({})
    end
    
    it "defaults a has entry to another hash" do
      subject.associations[:person_ids].must_equal({})
    end
    
  end # associations
  
  describe "JSON" do
    it "offers the attributes as_json" do
      subject.name = "Joe Entity"
      subject.as_json.must_equal({name: "Joe Entity"})
    end
  
    it "serializes the attributes into JSON" do
      subject.name = "Joe Entity"
      subject.arbitrary_attribute = "Panda"
      json = subject.to_json
      hsh = JSON(json)
      hsh["name"].must_equal "Joe Entity"
      hsh["arbitrary_attribute"].must_equal "Panda"
    end
  
    it "can create a entity from_json" do
      subject.name = "Special Entity"
      json = subject.to_json
      subject2 = Entity.from_json(json)
      subject2.name.must_equal subject.name
    end
    
    it "can create an entity from a hash" do
      hsh = {name: "Panda"}
      subject = Entity.hydrate(hsh)
      subject.name.must_equal "Panda"
    end
  end # JSON
end
