require 'database_boundary'
require 'find_entity_by_id'
require 'save_entity'
require 'filter_entities'
require 'save_database'
require 'load_database'

module Cradle
  class BasicRepository < DatabaseBoundary

    def self.stored_entities
      @stored_entities ||= {}
    end

    def self.overwrite_stored_entities!(value)
      @stored_entities = value
    end

    def find_by_id(id)
      interactor = FindEntityById.new(id)
      interactor.execute!
    end

    def save(entity)
      interactor = SaveEntity.new(entity)
      interactor.execute!
    end

    def filter(query)
      interactor = FilterEntities.new(query)
      interactor.execute!
    end

    def backup_database(*args)
      interactor = SaveDatabase.new(*args)
      interactor.execute!
    end

    def restore_database(*args)
      interactor = LoadDatabase.new(*args)
      interactor.execute!
    end

  end
end
