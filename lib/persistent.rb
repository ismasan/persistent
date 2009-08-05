module Persistent
  
  autoload :Store, 'lib/persistent/store'
  
  # This module gives you objects:
  #
  #    class Person
  #      include Persistent
  #
  #       attr_accessor :name, :last_name
  #    end
  #
  #    Person.store = Persistent::Store.new('/path/to/store_file.store') # or anything that looks like a Hash.
  #
  #    o = Person.new
  #
  #    o.name = 'Ismael'
  #    o.last_name = 'Celis'
  #
  #    # == Save and namespace unique ID by class name
  #
  #    o.persist! 'some_unique_id'
  #
  #    o2 = Person.find( 'some_unique_id' )
  #
  #    o2.name # => 'Ismael'
  #
  #    o2 == o # => true
  #
  #    o.destroy!
  #
  def self.included(base)
    base.extend ClassMethods
    class << base
      attr_accessor :store
    end
    
    # The only reason an instance wants to know about their persistence id is so we can call destroy! on it.
    # Why not use auto-generated ID's? Because I might want to use them as URL permalinks, for example
    #
    base.class_eval do
      attr_accessor :_persisted_id
    end
  end
  
  def persist!(id)
    self._persisted_id = id
    store[persistent_key(id)] = self
  end
  
  def destroy!
    return false unless self._persisted_id
    store.delete(persistent_key(_persisted_id))
  end
  
  protected
  
  def store
    self.class.store
  end
  
  def persistent_key(id)
    self.class.persistent_key(id)
  end
  
  # Class methods ::::::::::::::::::::::::::::::::::::::::::::
  #
  module ClassMethods
    
    def find(id)
      o = store[persistent_key(id)]
      o._persisted_id = id
      o
    end
    
    def exists?(id)
      !store[persistent_key(id)].nil?
    end
    
    # 'Person/abc'
    #
    def persistent_key(id)
      File.join(self.name.to_s, id.to_s)
    end
    
  end
  
end