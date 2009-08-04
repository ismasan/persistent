module Persistent
  module Persistence
    
    # This module gives you objects:
    #
    #    class Person
    #      include Persistent::Attributes
    #      include Persistent::Persistence
    #
    #      attribute :name, :last_name, :email
    #
    #      def initialize(id)
    #        self.id = id
    #        self.attributes = store.fetch(id, {})
    #      end
    #    end
    #
    #    Person.store = Persistent::Store.new('/path/to/store_file.store') # or anything that looks like a Hash.
    #
    #    o = Person.new( 'some_unique_id' )
    #
    #    o.name = 'Ismael'
    #    o.last_name = 'Celis'
    #
    #    o.save!
    #
    #    o2 = Person.new( 'some_unique_id' )
    #
    #    o2.name # => 'Ismael'
    #
    #    o2 == o # => true
    #
    #    o.destroy!
    #
    #    Person.all.size # => 0
    #
    def self.included(base)
      unless base.instance_methods.include?('attributes') && base.instance_methods.include?('id')
        raise NoMethodError, "object must implement :attributes and :id"
      end
      base.extend ClassMethods
      class << base
        attr_accessor :store
      end
    end
    
    def update_attributes(hash)
      hash.each do |k,v|
        send("#{k}=", v)
      end
    end
    
    def save!
      store[id] = attributes
    end
    
    def destroy!
      store.delete(id)
    end
    
    protected
    
    def store
      self.class.store
    end
    
    # Class methods ::::::::::::::::::::::::::::::::::::::::::::
    #
    module ClassMethods
      
      def exists?(id)
        !store[id].nil?
      end

      def all
        store.map {|id| new(id)}
      end
    end
    
  end
end