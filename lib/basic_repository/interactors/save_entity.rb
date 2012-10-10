require 'basic_repository'

module Cradle
  class SaveEntity

    attr_reader :entity, :id
    
    def initialize(entity)
      @id = entity[:id]
      raise ArgumentError, "Entity must have an id" unless @id
      @entity = entity
    end
    
    def execute!
      BasicRepository.stored_entities[id] = entity
      true
    end
  end
end
