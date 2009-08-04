require 'pstore'
module Persistent
  class Store
    include Enumerable
    
    def initialize(key)
      @store = PStore.new(key)
    end
    
    def [](key)
      @store.transaction{@store[key]}
    end
    
    def []=(key, value)
      @store.transaction{@store[key] = value}
    end
    
    def fetch(key, default)
      @store.transaction{@store.fetch(key, default)}
    end
    
    def delete(key)
      @store.transaction{@store.delete(key)}
    end
    
    def each(&block)
      roots = @store.transaction{@store.roots}
      roots.each(&block)
    end
  end
end