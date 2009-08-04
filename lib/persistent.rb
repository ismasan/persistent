module Persistent
  
  
  def self.included(base)
    base.send :include, Attributes
    base.send :include, Persistence
  end
  
  autoload :Store,        'lib/persistent/store'
  autoload :Persistence,  'lib/persistent/persistence'
  autoload :Attributes,   'lib/persistent/attributes'
end