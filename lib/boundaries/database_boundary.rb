require 'abstract_interface'

class DatabaseBoundary
  include AbstractInterface
  
  def find_by_id(id)
    DatabaseBoundary.api_not_implemented(self)
  end
  
  def filter(query)
    DatabaseBoundary.api_not_implemented(self)
  end
  
  def sample(query)
    DatabaseBoundary.api_not_implemented(self)
  end
  
  def save(entity)
    DatabaseBoundary.api_not_implemented(self)
  end
  
  def save_batch(entities)
    DatabaseBoundary.api_not_implemented(self)
  end
  
  def stream_import(io)
    DatabaseBoundary.api_not_implemented(self)
  end
  
  def stream_export(io)
    DatabaseBoundary.api_not_implemented(self)
  end
end
