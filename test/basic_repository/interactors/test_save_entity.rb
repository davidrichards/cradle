require 'minitest_helper'
require 'save_entity'

include Cradle

describe SaveEntity do
  subject do
    SaveEntity.new(entity)
  end
  
  let(:entity) do
    {
      :id => 123,
      :name => "Panda"
    }
  end
  
  it "requires an entity as a hash-like structure" do
    ->{SaveEntity.new}.must_raise ArgumentError
    ->{SaveEntity.new(:not_a_hash_like_structure)}.must_raise TypeError
  end
  
  it "requires entity to have :id in it" do
    entity.delete(:id)
    ->{SaveEntity.new(entity)}.must_raise ArgumentError
  end
  
  it "raises an error if there is an error during processing" do
    stored_entities = mock()
    stored_entities.expects(:[]=).with(entity[:id], entity).raises(StandardError)
    BasicRepository.expects(:stored_entities).returns(stored_entities)
    ->{subject.execute!}.must_raise StandardError
  end
  
  it "stores the entity in BasicRepository.stored_entities with the id as the key" do
    stored_entities = mock()
    stored_entities.expects(:[]=).with(entity[:id], entity)
    BasicRepository.expects(:stored_entities).returns(stored_entities)
    subject.execute!
  end
  
  it "never adds to the stored_entities (tests are properly mocked)" do
    BasicRepository.stored_entities.must_equal({})
  end
  
  it "overrides other entities, if the same key is used" do
    stored_entities = {}
    BasicRepository.expects(:stored_entities).times(3).returns(stored_entities)
    subject.execute!
    entity[:name] = "Bear"
    subject.execute!
    BasicRepository.stored_entities[entity[:id]][:name].must_equal "Bear"
  end
  
  it "returns true if it saves correctly" do
    stored_entities = {}
    BasicRepository.expects(:stored_entities).returns(stored_entities)
    subject.execute!.must_equal true
  end

end
