require 'yaml'
require 'basic_repository'

module Cradle

  class FileMissing < CradleError; end

  class LoadDatabase

    attr_reader :filename, :options

    def initialize(filename, options={})
      @filename = filename
      @options = options
    end

    def execute!
      check_file!
      load_file!
      true
    end

    private

    def load_file!
      contents = YAML.load_file(filename)
      BasicRepository.overwrite_stored_entities!(contents)
    end

    def check_file!
      raise FileMissing, "Cannot find file: #{filename}" unless file_exists?
    end

    def file_exists?
      File.exists?(filename)
    end

  end
end
