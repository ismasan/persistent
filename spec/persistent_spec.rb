require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class PersistentPerson
  include Persistent
  
  include Comparable
  
  attr_accessor :name, :last_name, :email
  
  def initialize(name, last_name, email)
    @name, @last_name, @meail = name, last_name, email
  end
  
  
  def <=>(other)
    self.name <=> other.name
  end
end

PersistentPerson.store = Hash.new # Persistent::Store.new('test.store')

describe Persistent do
  
  before do
    @person = PersistentPerson.new('ismael', 'celis', nil)
  end
  
  describe 'saving' do
    it "should persists" do
      @person.name = 'foo'
      @person.last_name = 'bar'
      @person.persist! 'abc'
      
      p2 = PersistentPerson.find('abc')
      p2.should == @person
      p2.name.should == 'foo'
      p2.last_name.should == 'bar'
      p2.email.should be_nil
    end

    it "should check it exists" do
      @person.persist! 'abc'
      PersistentPerson.exists?('abc').should be_true
      PersistentPerson.exists?('zzz').should_not be_true
    end
    
    it "should destroy" do
      @person.persist! 'abc'
      PersistentPerson.exists?('abc').should be_true
      @person.destroy!
      PersistentPerson.exists?('abc').should be_false
    end
  end
  
end
