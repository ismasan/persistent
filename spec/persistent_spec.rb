require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

module Persistent
  class Test
    include Persistent
    
    attribute :name, :last_name
    
    def initialize(id)
      self.id = id
      self.attributes = store.fetch(id, {})
    end
    
  end
end

describe "Persistent" do
  before do
    Persistent::Test.store = Hash.new
    @test = Persistent::Test.new('abc')
  end
  
  it "should have attributes" do
    @test.respond_to?(:name).should be_true
    @test.respond_to?(:last_name).should be_true
  end
  
  it "should persist" do
    @test.name = 'foo'
    @test.save!
    Persistent::Test.exists?('abc').should be_true
    Persistent::Test.new('abc').should == @test
  end
end
