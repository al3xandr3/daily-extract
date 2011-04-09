
require File.dirname(__FILE__) + '/../src/jsecureftp.rb'

describe "SecureFTP helper (generic sftp)" do

  it "should list contents - default" do
    SecureFTP::list.should_not be_empty
  end

  it "should raise an error when fails sending a file - default" do
    lambda { SecureFTP::send("","") .should raise_error(StandardError) }.should raise_error(StandardError)
  end

 #-------SERV1 -----------------

 it "should connect - serv1" do
     SecureFTP::list(:serv1).should_not be_empty
 end

 it "should raise an error when fails sending a file - serv1" do
    lambda { SecureFTP::send("","", :serv1) .should raise_error(StandardError) }.should raise_error(StandardError)
 end

end
