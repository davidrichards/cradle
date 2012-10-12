require 'minitest_helper'
require 'filter_entities'

include Cradle

describe FilterEntities do
  subject do
    FilterEntities.new(query)
  end
  
  let(:query) do
    {}
  end

  it "raises an error if there is not a query sent to it" do
    ->{FilterEntities.new}.must_raise ArgumentError
    subject.query.must_equal query
  end

  it "doesn't supress any errors that occur while running" do
    subject.expects(:build_executable_query).with(query).raises(StandardError)
    ->{subject.execute!}.must_raise StandardError
  end

  it "converts the query into runnable code" do
    stored_entities = mock()
    BasicRepository.expects(:stored_entities).returns(stored_entities)
    mock_lambda = mock()
    mock_lambda.expects(:call).with(stored_entities).returns(:results)
    subject.expects(:build_executable_query).with(query).returns(mock_lambda)
    subject.execute!.must_equal :results
  end

  it "runs the runnable code against the database" do
    stored_entities = mock()
    BasicRepository.expects(:stored_entities).returns(stored_entities)
    mock_lambda = mock()
    mock_lambda.expects(:call).with(stored_entities).returns(:results)
    subject.expects(:build_executable_query).with(query).returns(mock_lambda)
    subject.execute!.must_equal :results
  end

  it "returns a list of found entites, if there are any" do
    first = {id: 1, name: "first"}
    second = {id: 2, name: "second"}
    data = [first, second]
    BasicRepository.expects(:stored_entities).returns(data)
    subject.query = {id: 1}
    subject.execute!.must_equal [first]
  end

  it "returns an empty Array if no results are found" do
    first = {id: 1, name: "first"}
    second = {id: 2, name: "second"}
    data = [first, second]
    BasicRepository.expects(:stored_entities).returns(data)
    subject.query = {id: 3}
    subject.execute!.must_equal []
  end

  # Use Case: FilterEntities
  # ---------------

  # Data:

  # * query
  # * list of entities

  # Primary Course
  # --------------

  # 1. user submits a query to the system
  # 2. system parses the query into runnable code
  # 3. system runs the runnable code against the database
  # 4. system returns a list of found entities, if there are any
  # 5. system returns an empty list if no results are found

  # Error Course
  # ------------

  # 1. system raises an error if there is not a query sent to it
  # 2. system returns an error if something goes wrong

end
