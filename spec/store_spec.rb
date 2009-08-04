require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Persistent::Store do
  
  before do
    @file_path = File.dirname(__FILE__)+'/test.store'
    @store = Persistent::Store.new(@file_path)
  end
  
  describe "hash interface" do
    %w([] []= fetch delete each).each do |m|
      it "should respond to :#{m}" do
        @store.respond_to?(m.to_sym).should be_true
      end
    end
  end
  
  describe 'setting' do
    
    after do
      FileUtils.rm(@file_path) if File.exists?(@file_path)
    end
    
    it "should persist data" do
      @store[:foo] = 'bar'
      second_store = Persistent::Store.new(@file_path)
      second_store[:foo].should == 'bar'
    end
  end
  
end