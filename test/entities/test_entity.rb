require_relative '../minitest_helper'
require 'entity'
require 'person'

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
    
    it "defaults the entries hash inside the associations to arrays" do
      subject.associations[:any][:thing].must_equal []
    end
    
    it "defaults a has entry to another hash" do
      subject.associations[:person_ids].must_equal({})
    end
    
    it "can add_association with another entity" do
      person = Person.new(name: "Person")
      subject.add_association(person, "predicate")
      associations = subject.associations["person_entries"]
      id = associations.keys.first
      predicates = associations[id]
      id.must_equal person.id
      predicates.must_equal ["predicate"]
    end
    
    it "can add more than one predicate at a time" do
      person = Person.new(name: "Person")
      subject.add_association(person, "author", "speaker")
      subject.associations["person_entries"][person.id].must_equal %w(author speaker)
    end
    
    it "can remove an association" do
      person = Person.new(name: "Person")
      subject.add_association(person, "author", "speaker")
      subject.remove_association(person, "author")
      subject.associations["person_entries"][person.id].must_equal %w(speaker)
    end
    
    it "can remove all associations with another entity" do
      person = Person.new(name: "Person")
      subject.add_association(person, "author", "speaker")
      subject.remove_associations(person)
      subject.associations["person_entries"][person.id].must_equal []
    end
    
    it "has a shortcut for the entity type associations" do
      person = Person.new(name: "Person")
      subject.add_association(person, "author")
      subject.person_entries.must_equal subject.associations["person_entries"]
      subject.concept_entries.must_equal({})
      subject.event_entries.must_equal({})
      subject.organization_entries.must_equal({})
      subject.project_entries.must_equal({})
      subject.publication_entries.must_equal({})
    end
    
  end # associations
  
  describe "JSON" do
    it "offers the attributes as_json" do
      subject.name = "Joe Entity"
      subject.as_json.must_equal({name: "Joe Entity"})
    end
    
    it "aliases to_hash to as_json (for regular people to understand)" do
      subject.name = "A Name"
      subject.to_hash.must_equal subject.as_json
    end
    
    it "uses the hash version for inspect (it's easier to read)" do
      subject.name = "A Name"
      subject.inspect.must_equal subject.as_json.inspect
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
    
    it "serializes associations" do
      person = Person.new(:name => "Author")
      subject.add_association(person, "author")
      json = subject.to_json
      subject2 = Entity.from_json(json)
      subject2.associations["person_entries"][person.id].must_equal ["author"]
    end
  end # JSON
end
