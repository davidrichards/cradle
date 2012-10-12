require 'minitest_helper'
require 'save_database'

include Cradle

describe SaveDatabase do
  subject do
    SaveDatabase.new(filename)
  end

  let(:filename) do
    "/tmp/test_save_database.yaml"
  end

  let(:dirname) do
    File.dirname(filename)
  end

  it "raises if no filename was provided" do
    ->{SaveDatabase.new}.must_raise(ArgumentError)
  end

  it "raises an error if anything goes wrong during processing" do
    subject.expects(:assert_directory!).raises(StandardError)
    ->{subject.execute!}.must_raise StandardError
  end

  it "tries to create the directory if it doesn't exist" do
    subject.expects(:directory_exists?).returns(false)
    FileUtils.expects(:mkdir_p).with(dirname).returns(true)
    subject.expects(:file_exists?).returns(false)
    subject.execute!
  end

  it "raises an error if it cannot create the directory" do
    subject.expects(:directory_exists?).returns(false)
    FileUtils.expects(:mkdir_p).with(dirname).returns(false)
    ->{subject.execute!}.must_raise DirectoryCannotBeCreated
  end

  it "writes a YAML version of BasicRepository.stored_entities to the file" do
    stored_entities = {id: 1}
    BasicRepository.expects(:stored_entities).returns(stored_entities)
    subject.expects(:directory_exists?).returns(true)
    subject.expects(:file_exists?).returns(false)
    subject.execute!
    found = YAML.load(File.read(filename))
    found.must_equal stored_entities
    FileUtils.rm(filename)
  end

  it "can have an overwrite policy from the option {overwrite: true}" do
    subject = SaveDatabase.new(filename, overwrite: true)
    subject.overwrite_policy.must_equal :overwrite!
  end

  it "can have an overwrite policy from the option {rotate_files: true} " do
    subject = SaveDatabase.new(filename, rotate_files: true)
    subject.overwrite_policy.must_equal :rotate!
  end

  it "raises an error if the file exists and there is no overwrite policy" do
    subject.expects(:file_exists?).returns(true)
    subject.expects(:has_overwrite_policy?).returns(false)
    ->{subject.execute!}.must_raise FileCannotBeOverwritten
  end

  it "overwrites the file if the policy is to overwrite" do
    File.open(filename, 'w') {|f| f.print "original"}
    subject.expects(:directory_exists?).returns(true)
    subject.expects(:file_exists?).returns(true)
    subject.expects(:yaml_contents).returns("overwrite")
    subject.options[:overwrite] = true
    subject.execute!
    found = YAML.load(File.read(filename))
    found.must_equal "overwrite"
    FileUtils.rm(filename)
  end

  it "rotates the files if the policy is to rotate_files" do
    subject.options[:rotate_files] = true
    subject.expects(:directory_exists?).returns(true)
    subject.expects(:file_exists?).returns(true)
    rotate_files = mock()
    rotate_files.expects(:execute!).returns(true)
    RotateFiles.expects(:new).with(filename, subject.options).returns(rotate_files)
    subject.expects(:write_contents!).returns(true)
    subject.execute!
  end

  it "returns true if all was successful" do
    subject.expects(:assert_directory!).returns(true)
    subject.expects(:manage_existing_files!).returns(true)
    subject.expects(:write_contents!).returns(true)
    subject.execute!.must_equal true
  end

end
