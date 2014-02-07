require 'spec_helper'

describe Illlocation::RspecTest do
  describe ".says_hello" do
    it "says hello" do
      Illlocation::RspecTest.say_hello.should == "hello"
    end
  end
end