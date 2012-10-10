require "delegate"

def Cradle::List klass
  list = DelegateClass(Array)
  list.class_eval do

    class << self
      attr_accessor :klass
    end

    def initialize(*args)
      super Array.new *args
    end

    def klass
      self.class.klass
    end

    def <<(object)
      raise ArgumentError, "Can only add #{klass}" unless object.is_a?(klass)
      super
    end

    def []=(index, object)
      raise ArgumentError, "Can only add #{klass}" unless object.is_a?(klass)
      super
    end
    
    def self.from_json(string)
      hydrate JSON(string)
    end

    def self.hydrate(arr)
      new.hydrate(arr)
    end

    def hydrate(arr)
      Array(arr).each do |e|
        self << klass.hydrate(e)
      end
      self
    end
  end
  list.klass = klass
  list
end

