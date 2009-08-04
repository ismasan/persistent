require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class PersistentPerson
  include Persistent::Attributes
  include Persistent::Persistence
  
  include Comparable
  
  attribute :name, :last_name, :email
  
  def initialize(id)
    self.id = id
    self.attributes = store.fetch(id, {})
  end
  
  
  def <=>(other)
    self.id <=> other.id
  end
end

PersistentPerson.store = Hash.new

describe Persistent::Persistence do
  
  before do
    @person = PersistentPerson.new('abc')
  end
  
  describe 'new record' do
    it "should be a new record" do
      @person.new_record?.should be_true
    end
    
    it "should not be a new record after saving" do
      @person.save!
      @person.new_record?.should be_false
    end
  end
  
  describe 'saving' do
    it "should persists" do
      @person.name = 'foo'
      @person.last_name = 'bar'
      @person.save!
      
      p2 = PersistentPerson.new('abc')
      p2.should == @person
      p2.name.should == 'foo'
      p2.last_name.should == 'bar'
      p2.email.should be_nil
    end

    it "should check it exists" do
      @person.save!
      PersistentPerson.exists?('abc').should be_true
      PersistentPerson.exists?('zzz').should_not be_true
    end
    
    it "should destroy" do
      @person.save!
      PersistentPerson.exists?('abc').should be_true
      @person.destroy!
      PersistentPerson.exists?('abc').should be_false
    end
  end
  
  describe 'fetching' do
    before do
      @p2 = PersistentPerson.new('bbb')
      @p3 = PersistentPerson.new('ccc')
      
      @person.save!
      @p2.save!
      @p3.save!
    end
    
    it "should find all" do
      PersistentPerson.all.should == [@person, @p2, @p3].sort
    end
  end
  
end