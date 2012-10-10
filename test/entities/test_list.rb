require_relative '../minitest_helper'
require 'entity'
require 'list'

include Cradle

describe "List" do
  before do
    EList = Cradle.List(Entity)
  end

  subject do
    EList.new
  end
  
  describe "setup" do
    
    it "should take an Object" do
      assert EList, "The List needs a class to be setup."
    end
    
    it "stores the governing class in klass" do
      EList.klass.must_equal Entity
    end
  end # setup
  
  it "must be something of type klass to get into the list" do
    ->{subject << 1}.must_raise ArgumentError
    ->{subject[0] = 1}.must_raise ArgumentError
    assert subject << Entity.new, "Can add entities"
  end
  
  it "acts like an Array" do
    subject << Entity.new(:entry => :first)
    subject << Entity.new(:entry => :second)
    subject.map(&:entry).must_equal [:first, :second]
  end

  describe "serialization" do
    it "can build from a list of hashes" do
      plain_ruby = [{name: :entity1}, {name: :entity2}]
      list = EList.hydrate(plain_ruby)
      list[0].name.must_equal :entity1
      list[1].name.must_equal :entity2
    end
    
    it "can build from JSON" do
      entity = Entity.new(name: "Panda")
      subject << entity
      json = subject.to_json
      subject2 = EList.from_json json
      subject2.first.name.must_equal "Panda"
    end
  end # serialization
end
