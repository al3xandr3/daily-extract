
require File.dirname(__FILE__) + '/../src/mailer.rb'
require File.dirname(__FILE__) + '/../src/logginator.rb'

describe "Mailer helper" do

  it "should send extracts log" do
    #to assure the file is created
    Logginator::create_if_needed.should_not be_nil
    Mailer::send_log.should include("250 2.0.0 Ok")
  end

  it "should send a mail" do
    Mailer::send_mail("MailerTest: subject","body").should include("250 2.0.0 Ok")
  end

end
