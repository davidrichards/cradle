require 'fileutils'
require 'yaml'
require 'basic_repository'
require 'rotate_files'

module Cradle

  class DirectoryCannotBeCreated < CradleError; end
  class FileCannotBeOverwritten < CradleError; end

  class SaveDatabase

    attr_reader :filename, :options

    def initialize(filename, options={})
      @filename = filename
      @options = options
    end

    def execute!
      assert_directory!
      manage_existing_files!
      write_contents!
      true
    end

    def has_overwrite_policy?
      overwrite_policy ? true : false
    end

    def overwrite_policy
      if options[:overwrite]
        :overwrite!
      elsif options[:rotate_files]
        :rotate!
      else
        nil
      end
    end

    private

    def overwrite!
      # Noop
    end

    def rotate!
      rotator = RotateFiles.new(filename, options)
      rotator.execute!
    end

    def write_contents!
      File.open(filename, 'w') {|f| f.print yaml_contents }
    end

    def manage_existing_files!
      return true unless file_exists?
      raise FileCannotBeOverwritten,
        "The file exists (#{filename}) but there is no overwrite policy." unless
        has_overwrite_policy?
      send(overwrite_policy)
    end

    def yaml_contents
      YAML.dump BasicRepository.stored_entities
    end

    def assert_directory!
      unless directory_exists?
        FileUtils.mkdir_p(dirname) or raise DirectoryCannotBeCreated, "Could not create #{dirname}."
      end
    end

    def dirname
      @dirname ||= File.dirname(filename)
    end

    def directory_exists?
      File.exists?(dirname)
    end

    def file_exists?
      File.exists?(filename)
    end

  end
end
