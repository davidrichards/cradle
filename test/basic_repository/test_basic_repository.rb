require 'minitest_helper'
require 'basic_repository'

include Cradle

describe BasicRepository do
  after do
    BasicRepository.send(:instance_variable_set, :@stored_entities, {})
  end
  
  subject do
    BasicRepository.new
  end
  
  it "has a basic hash, stored_entities, as a singleton" do
    BasicRepository.stored_entities.must_equal({})
  end
  
  it "has a simple inspect, so that large-ish repositories don't take over console sessions" do
    100.times {|i| BasicRepository.stored_entities[i] = "abcde"}
    assert BasicRepository.inspect.length < 100, "I don't really care what the inspect is, just that it's never too verbose."
  end
  
  describe "find_by_id" do
    it "uses FindEntityById to lookup a repository entity" do
      interactor = mock()
      interactor.expects(:execute!).returns(:result)
      FindEntityById.expects(:new).with(:id).returns(interactor)
      subject.find_by_id(:id).must_equal(:result)
    end
  end # find_by_id
  
  describe "save" do
    it "uses SaveEntity to store an entity" do
      interactor = mock()
      interactor.expects(:execute!).returns(:result)
      hash = {}
      SaveEntity.expects(:new).with(hash).returns(interactor)
      subject.save(hash).must_equal(:result)
    end
  end # save

end
