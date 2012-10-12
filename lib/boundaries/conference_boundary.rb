require 'abstract_interface'

class ConferenceBoundary
  include AbstractInterface

  def attend(person, event)
    DatabaseBoundary.api_not_implemented(self)
  end

  def speak_at(person, event)
    DatabaseBoundary.api_not_implemented(self)
  end

  def sponsor(organization, event)
    DatabaseBoundary.api_not_implemented(self)
  end

  def set_schedule(event)
    DatabaseBoundary.api_not_implemented(self)
  end

end
