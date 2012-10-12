require 'minitest_helper'
require 'basic_repository'

include Cradle

describe BasicRepository do
  after do
    BasicRepository.overwrite_stored_entities!({})
  end

  subject do
    BasicRepository.new
  end

  it "has a basic hash, stored_entities, as a singleton" do
    BasicRepository.stored_entities.must_equal({})
  end

  it "can replace the stored_entities with overwrite_stored_entities!" do
    BasicRepository.overwrite_stored_entities! :some_value
    BasicRepository.stored_entities.must_equal :some_value
    BasicRepository.overwrite_stored_entities!({})
  end

  it "has a simple inspect, so that large-ish repositories don't take over console sessions" do
    100.times {|i| BasicRepository.stored_entities[i] = "abcde"}
    assert BasicRepository.inspect.length < 100, "I don't really care what the inspect is, just that it's never too verbose."
  end

  it "uses FindEntityById to lookup a repository entity" do
    interactor = mock()
    interactor.expects(:execute!).returns(:result)
    FindEntityById.expects(:new).with(:id).returns(interactor)
    subject.find_by_id(:id).must_equal(:result)
  end

  it "uses SaveEntity to store an entity" do
    interactor = mock()
    interactor.expects(:execute!).returns(:result)
    hash = {}
    SaveEntity.expects(:new).with(hash).returns(interactor)
    subject.save(hash).must_equal(:result)
  end

  it "uses FilterEntities to find entities" do
    interactor = mock()
    interactor.expects(:execute!).returns(:result)
    hash = {}
    FilterEntities.expects(:new).with(hash).returns(interactor)
    subject.filter(hash).must_equal(:result)
  end

  it "uses SaveDatabase to backup the database to file" do
    interactor = mock()
    interactor.expects(:execute!).returns(:result)
    filename = "file.yaml"
    SaveDatabase.expects(:new).with(filename).returns(interactor)
    subject.backup_database(filename).must_equal(:result)
  end

  it "uses LoadDatabase to restore the database from a file" do
    interactor = mock()
    interactor.expects(:execute!).returns(:result)
    filename = "file.yaml"
    LoadDatabase.expects(:new).with(filename).returns(interactor)
    subject.restore_database(filename).must_equal(:result)
  end

end
