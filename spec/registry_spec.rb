require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class Parent
  extend Registry
end

class Stacey < Parent
end

class Tracey < Parent
  indentifier :child, :female
  
  def method_call
  end
end


describe Registry do
  describe "Parent" do
    it "should respond to for" do
      Parent.should respond_to :for
    end
  end
  
  describe Stacey, Tracey do
    it "should automatically register the class name" do
      lambda { Parent.for(:stacey) { true } }.should be_true
    end
    
    it "should be registered to handle child" do
      Tracey.should_receive(:method_call)
      Parent.for(:child) { method_call }
    end
    
    it "should be registered to handle child" do
      Tracey.should_receive(:method_call)
      Parent.for(:female) { method_call }
    end
    
    it "should raise NotRegistered for unregistered classes" do
      lambda { Parent.for(:xyz) { method_call } }.should raise_error(Registry::NotRegistered)
    end
  end
end
