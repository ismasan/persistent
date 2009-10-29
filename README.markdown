## Basic persistence functionality for your Ruby objects

This is a drop-in thin persistence layer for your Ruby objects. I wrote it for some toy Sinatra apps I'm writing because I can't be bothered with using DataMapper, CouchDB and the rest for something so small.

The store can be anything that looks like a Hash.

From the code comments:

    class Person
      include Persistent
      attr_accessor :name, :last_name
    end
    
    Person.store = Persistent::Store.new('/path/to/store_file.store') # or anything that looks like a Hash.
    
    o = Person.new
    
    o.name = 'Ismael'
    o.last_name = 'Celis'
    
    # == Save and namespace unique ID by class name
    
    o.persist! 'some_unique_id'
    
    o2 = Person.find( 'some_unique_id' )
    
    o2.name # => 'Ismael'
    
    o2 == o # => true
    
    o.destroy!

    Person.find( 'some_unique_id' ) # => nil


## Usage

You can persist individual objects by key

    o = SomeObject.new
    o.persist! 'some_key'

Keys are internally prefixed with the object's class name so you can store objects of different types using the same keys.

... But after conversation with Martyn (http://github.com/mloughran) I'm planning to store one big object with the whole domain object space in it, so I can store the whole thing at once and forget about persistance and have fun with pure Ruby objects (look ma, no database!).

I know. That only works because my particular domain is tiny.


## Object store

Persistent::Store wraps Standard library's PStore to save objects to the filesystem in a transaction.

Persistent::Store itself quacks like a Hash (:[], :[]=, :fetch, :delete and :each) so you can use a Hash, Memcached, another wrapper like Moneta (http://github.com/wycats/moneta/tree/master) or you own object store.

## Installation

This is so tiny that you can just copy the lib/persistent.rb and lib/persistent/store.rb files in you project (or clone them of course).

You can also use it as a gem:
    # If you haven't done this before:
    gem sources -a http://gemcutter.org

    sudo gem install persistent

And then in your code:

    require 'rubygems'
    require 'persistent'

    class SomeClass
      include Persistent
      ...
    end

## Other alternatives

This library is meant for simple use cases. If you want serious object persistence please check solutions such as CouchDB (http://couchdb.apache.org/), DataMapper (http://github.com/datamapper/dm-core/tree/master) or the similarly named Persistable gem (http://github.com/andykent/persistable/tree/master).

Also, Stone (http://github.com/ndemonner/stone/tree/master) looks pretty neat!