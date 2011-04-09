
require File.dirname(__FILE__) + '/../src/timeutils.rb'

describe "Time Helper Class" do

  before(:each) do
     @now = Time.now
     @dtnow = DateTime.now
     @seconds = {
       1.minute   => 60,
       10.minutes => 600,
       1.hour + 15.minutes => 4500,
       2.days + 4.hours + 30.minutes => 189000,
       5.years + 1.month + 1.fortnight => 161481600
     }
   end

   it "should support several basic units" do
     @seconds.each { |actual, expected| actual.should == expected }
   end

   it "should calculate correct intervals" do
     @seconds.values.each do |seconds|
       seconds.since(@now).should == @now + seconds
       seconds.until(@now).should == @now - seconds
     end
   end

   # Test intervals based from Time.now
   it "should calculate correctly ago and from_now" do
     @seconds.values.each do |seconds|
       now = Time.now
       seconds.ago.should >= now - seconds
       seconds.from_now.should >= now + seconds
     end
   end
   
   it "should calculate correctly before word" do
     10.days.before.day.should == (@now-10.days).day
     10.hours.before.hour.should == (@now-10.hours).hour
   end
   
   it "should should_after" do
      10.days.after.day.should == (@now+10.days).day
      10.hours.after.hour.should == (@now+10.hours).hour
   end

end

