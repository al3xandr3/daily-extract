
require File.dirname(__FILE__) + '/../src/logginator.rb'

describe "Logginator helper" do

  it "should always return a logger" do
    Logginator::should_not be_nil
  end

  it "should have_fatal" do
    Logginator::should be_respond_to("fatal")
  end

  it "should have_warn" do
    Logginator::should be_respond_to("warn")
  end

  it "should have_info" do
    Logginator::should be_respond_to("info")
  end

  it "should have_error" do
    Logginator::should be_respond_to("error")
  end

  it "should log info types without error" do
    Logginator::info("log into").should be_true
  end

  it "should log warn types without error" do
    Logginator::warn("log warn").should be_true
  end

  it "should log fatal types without error" do
    Logginator::fatal("log fatal").should be_true
  end

  it "should log error types without error" do
    Logginator::error("log error").should be_true
  end

end
