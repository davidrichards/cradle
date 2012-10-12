require 'abstract_interface'

class CRUDBoundary
  include AbstractInterface

  def find_or_create_by_keys(entity, *keys)
    DatabaseBoundary.api_not_implemented(self)
  end

  def create_entity(entity)
    DatabaseBoundary.api_not_implemented(self)
  end

  def find_entity(id_or_query)
    DatabaseBoundary.api_not_implemented(self)
  end

  def update_entity(entity)
    DatabaseBoundary.api_not_implemented(self)
  end

  def destroy_entity(entity)
    DatabaseBoundary.api_not_implemented(self)
  end

end
