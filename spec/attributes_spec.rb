require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class Person
  include Persistent::Attributes
  
  attribute :name, :last_name, :email
  
end

describe Persistent::Attributes do
  
  before do
    @person = Person.new
  end
  
  describe 'initializing' do
    
    it "should respond to :id" do
      @person.respond_to?(:id).should be_true
    end
    
    it 'should respond to defined attributes' do
      @person.respond_to?(:name).should be_true
      @person.respond_to?(:last_name).should be_true
      @person.respond_to?(:email).should be_true
    end
  end
  
  describe 'setting' do
    it 'should set and read attributes' do
      @person.id = 'abc'
      @person.name = 'Ismael'
      @person.last_name = 'Celis'
      @person.email = 'ismael@example.com'
      
      @person.id.should == 'abc'
      @person.name.should == 'Ismael'
      @person.last_name.should == 'Celis'
      @person.email.should == 'ismael@example.com'
      
      @person.attributes.should == {:name => 'Ismael', :last_name => 'Celis', :email => 'ismael@example.com'}
    end
  end
end