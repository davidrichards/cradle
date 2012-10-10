require 'basic_repository'

module Cradle
  class FindEntityById

    attr_reader :id
    
    def initialize(id)
      @id = id
    end
    
    def execute!
      BasicRepository.stored_entities[id]
    end
  end
end
