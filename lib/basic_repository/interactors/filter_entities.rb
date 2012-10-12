require 'basic_repository'

module Cradle
  class FilterEntities

    attr_accessor :query

    def initialize(query)
      @query = query
    end

    def execute!
      executable = build_executable_query(query)
      executable.call(BasicRepository.stored_entities)
    end

    def build_executable_query(query)
      ->(data) do
        data.select do |e|
          query.all? {|key, value| e[key] == value}
        end
      end
    end
    private :build_executable_query

  end
end
