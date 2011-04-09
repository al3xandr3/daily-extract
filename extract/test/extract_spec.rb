
require File.dirname(__FILE__) + '/../src/extract.rb'

describe "Extract Tests" do
  
  before(:each) do
    @extr = Extract.new
  end

 it "should have a query method" do
    @extr.query('testq', Time.days_ago(4)).should_not be_empty
 end
 
 it "should have a execute method" do
   @extr.execute('testb', Time.days_ago(4)).should == true
 end

 it "should generate correct output" do
   fname = File.dirname(__FILE__) + "/../out/" + "output_file.txt"
   @extr.output([["mambo","mambo2","PT"]], fname)
   fl = File.open(fname)
   fl.readline.should == "COL1|COL2|COL3\n"
   fl.readline.should == "mambo|mambo2|PT\n"
   fl.readline.should == "#END#\n"
   fl.close
   File.delete(fname)
 end
 
 it "should clean tables when it finishes running" do
   @extr.clean_tables.should == true
 end
 
 it "should check output file size" do
   @extr.filesize_is_valid?(__FILE__, (40..100)).should == true
   @extr.filesize_is_valid?(__FILE__, (4..10)).should == false
 end
 
end

describe "Queue Loader" do
  
  it "should load queue ToDo" do
    valu  = queue_load 'todo3.queue'
    valu.should be_instance_of(Array)
  end
 
  it "should be able to unload" do
    a = queue_load 'todo3.queue'
    a << "test_task"
    queue_unload(a, 'todo3.queue')
    b = queue_load 'todo3.queue'
    b.last.should == "test_task"
    b.shift
    queue_unload(b, 'todo3.queue')
    File.delete('todo3.queue')
  end

end

