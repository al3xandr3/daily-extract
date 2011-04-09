
require File.dirname(__FILE__) + '/../src/jdatabase.rb'
require 'erb'

describe "DataBase Helper" do

  before(:each) do
    @db = Database.new
  end

  it "should connect" do
    @db.should be_connected
  end

  it "should have a query mode" do
    @db.query("SELECT CURRENT_TIMESTAMP;").should_not be_nil
  end

  it "should have execute mode" do
    @db.execute("SELECT CURRENT_TIMESTAMP;").should_not be_nil
  end

  it "should read ERB and execute query" do
    f = File.open(File.dirname(__FILE__) + '/../src/sql/query_testq.sql')
    quer = ERB.new(f.read).result(binding)
    #query to get top 3 rows
    @db.query(quer).size.should == 3
  end

end
