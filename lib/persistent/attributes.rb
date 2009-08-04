module Persistent
  module Attributes
    
    # This module provides your objects with an :attributes hash and an :id accessor
    # These two are the interface for the Persistence module
    #
    def self.included(base)
      base.extend ClassMethods
      base.class_eval do
        attr_writer :attributes
        attr_accessor :id
      end
    end
    
    def attributes
      @attributes ||= {}
    end
    
    module ClassMethods
      
      #== Setters and getters
      # 
      # Example:
      #    attribute :name
      #
      # Creates:
      #
      #    def name=(str)
      #      attributes[:name] = str
      #    end
      # 
      #    def name
      #      attributes[:name]
      #    end
      #
      def attribute(*attrs)
        attrs.each do |attr|
          class_eval %(
          def #{attr.to_s}
            attributes[:#{attr.to_s}]
          end
          
          def #{attr.to_s}=(v)
            attributes[:#{attr.to_s}] = v
          end
          )
        end
      end
      
    end
    
    
  end
end