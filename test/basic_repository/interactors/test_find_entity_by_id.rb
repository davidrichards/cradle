require 'minitest_helper'
require 'find_entity_by_id'

include Cradle

describe FindEntityById do
  subject do
    FindEntityById.new(id)
  end
  
  let(:id) {123}

  it "requires an id" do
    ->{FindEntityById.new}.must_raise ArgumentError
    subject.id.must_equal id
  end
  
  it "raises an error if there is an error during processing" do
    stored_entities = mock()
    stored_entities.expects(:[]).with(id).raises(StandardError)
    BasicRepository.expects(:stored_entities).returns(stored_entities)
    ->{subject.execute!}.must_raise StandardError
  end
  
  it "returns the lookup from BasicRepository.stored_entities" do
    stored_entities = mock()
    stored_entities.expects(:[]).with(id).returns(:result)
    BasicRepository.expects(:stored_entities).returns(stored_entities)
    subject.execute!.must_equal :result
  end
  
  it "returns nil if nothing was found" do
    BasicRepository.expects(:stored_entities).returns({})
    subject.execute!.must_be_nil
  end
end
