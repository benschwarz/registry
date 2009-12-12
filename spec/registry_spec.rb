require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class Parent
  extend Registry
end

class Stacey < Parent
  identifier "pretty", :fine
end

class Tracey < Parent
  identifier :child, :female
  
  def self.echo(string)
    string
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
      Tracey.should_receive(:echo)
      Parent.for(:child) { echo }
    end
    
    it "should be registered to handle child" do
      Tracey.should_receive(:echo)
      Parent.for(:female) { echo }
    end
    
    it "should raise NotRegistered for unregistered classes" do
      lambda { Parent.for(:xyz) { echo } }.should raise_error(Registry::NotRegistered)
    end
    
    it "should return the results of the method call" do
      Parent.for(:female) { echo("abc") }.should == "abc"
    end
    
    it "should return the matching class when called without a block" do
      Parent.for(:female).should == Tracey 
    end
    
    it "should respond to either string or symbol identifiers" do
      Parent.for(:pretty).should == Stacey
      Parent.for("fine").should == Stacey
    end
    
    it "should call the class" do
      Parent.for(:child).echo("abc").should == "abc"
    end
  end
end
