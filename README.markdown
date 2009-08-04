## Basic persistence functionality for your Ruby objects

This is not quite an object store at the moment, just a file-system based store for your object attributes. 

The store can be anything that looks like a Hash.

From the code:

    class Person
      include Persistent
    
      attribute :name, :last_name, :email
    
      def initialize(id)
        self.id = id
        self.attributes = store.fetch(id, {})
      end
    end

    Person.store = Persistent::Store.new('/path/to/store_file.store') # or anything that looks like a Hash.
    
    o = Person.new( 'some_unique_id' )
    
    o.name = 'Ismael'
    o.last_name = 'Celis'
    
    o.save!
    
    o2 = Person.new( 'some_unique_id' )
    
    o2.name # => 'Ismael'
    
    o2 == o # => true
    
    o.destroy!
    
    Person.all.size # => 0

## TODO

Simplify this by storing whole objects instead of attributes. Stop thinking about relational databases!

For one, the current implementation forces me to initialize objects with an ID. I want to initialize my objects however I want and just store them when I'm done. Something like:

    p = Person.new('Ismael', 'Celis')

    p.do_sonething!

    Person.save! 'some_unique_id', p # namespaces key by class so IDs don't collide

    Person.find 'some_unique_id' # => p