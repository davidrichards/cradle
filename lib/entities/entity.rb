require 'ostruct'
require 'uuid'

class Cradle::Entity < OpenStruct
  
  def id
    @table[:id] ||= UUID.generate
  end
  
  # ================
  # = Associations =
  # ================
  def associations
    @table[:associations] ||= Hash.new {|h, k| h[k] = Hash.new {|h2, k2| h2[k2] = []}}
  end
  
  def add_association(entity, *predicates)
    id = entity.id
    entry_name = get_entry_name(entity)
    predicates.each do |predicate|
      associations[entry_name][id] |= [predicate]
    end
  end
  
  def remove_association(entity, predicate)
    id = entity.id
    entry_name = get_entry_name(entity)
    associations[entry_name][id].delete(predicate)
  end
  
  def remove_associations(entity)
    id = entity.id
    entry_name = get_entry_name(entity)
    associations[entry_name].delete(id)
  end
  
  def concept_entries; associations["concept_entries"]; end
  def event_entries; associations["event_entries"]; end
  def organization_entries; associations["organization_entries"]; end
  def person_entries; associations["person_entries"]; end
  def publication_entries; associations["publication_entries"]; end
  def project_entries; associations["project_entries"]; end
    
  # =================
  # = Serialization =
  # =================
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

  private
  def get_entry_name(entity)
    entity.class.name.split("::").last.downcase + "_entries"
  end
  
end
