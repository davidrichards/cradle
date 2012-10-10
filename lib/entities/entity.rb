require 'ostruct'
require 'uuid'

class Cradle::Entity < OpenStruct
  
  def id
    @table[:id] ||= UUID.generate
  end
  
  def associations
    @table[:associations] ||= Hash.new {|h, k| h[k] = {}}
  end
  
  def to_json(*args)
    JSON.dump(as_json(*args))
  end
  
  def as_json(*args)
    @table
  end
  
  def self.from_json(string)
    hydrate JSON(string)
  end
  
  def self.hydrate(hsh)
    new(hsh)
  end

end
