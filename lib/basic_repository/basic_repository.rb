require 'database_boundary'
require 'find_entity_by_id'
require 'save_entity'
require 'filter_entities'

module Cradle
  class BasicRepository < DatabaseBoundary
    
    def self.stored_entities
      @stored_entities ||= {}
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
    
  end
end
