require 'minitest_helper'
require 'load_database'

include Cradle

describe LoadDatabase do
  subject do
    LoadDatabase.new(filename)
  end

  let(:filename) do
    "/tmp/test_load_database.yaml"
  end

  let(:dirname) do
    File.dirname(filename)
  end

  it "raises if no filename was provided" do
    ->{LoadDatabase.new}.must_raise(ArgumentError)
  end

  it "raises an error if anything goes wrong during processing" do
    subject.expects(:check_file!).raises(StandardError)
    ->{subject.execute!}.must_raise StandardError
  end

  it "raises an error if the file does not exist" do
    subject.expects(:file_exists?).returns(false)
    ->{subject.execute!}.must_raise FileMissing
  end

  it "replaces the stored_entities with the loaded file contents" do
    expected = "some contents"
    File.open(filename, 'w') {|f| f.print(expected)}
    BasicRepository.expects(:overwrite_stored_entities!).with(expected).returns(true)
    subject.execute!
    FileUtils.rm_rf(filename)
  end

  it "returns true if everything works well" do
    subject.expects(:check_file!).returns(true)
    subject.expects(:load_file!).returns(true)
    subject.execute!.must_equal true
  end

end
