require 'minitest_helper'
require 'rotate_files'

include Cradle

describe RotateFiles do
  subject do
    RotateFiles.new(filename)
  end

  let(:filename) do
    "/tmp/test_save_database.yaml"
  end

  let(:dirname) do
    File.dirname(filename)
  end

end
