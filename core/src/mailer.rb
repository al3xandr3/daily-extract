
require 'net/smtp'
require File.dirname(__FILE__) + '/timeutils.rb'
require File.dirname(__FILE__) + '/logginator.rb'

class Mailer

  def self.send_log(subject="")
    log_file = Logginator::get_log_path
    raise "Log file does not exists" unless File.exists?(log_file)

    body = "<H1>Log:</H1>"
    body <<  "<pre>" + File.open(log_file).read.gsub("/n","<br>") + "</pre>"

    send_mail(subject, body)
  end

  def self.send_mail(subject="Extract", body='<H1>Title</H1><p>Regards, Alex</p>')

    msgstr = <<END_OF_MESSAGE
From: automations@domain.com
To: reciever@domain.com
MIME-Version: 1.0
Content-type: text/html
Subject: [extract] #{subject}
Date: #{Time.now}

#{body}
END_OF_MESSAGE

    Net::SMTP.start('mail.domain.com') do |smtp|
      Logginator::info "mailing: #{subject}"
      smtp.send_message(msgstr, "reciever@domain.com", "reciever@domain.com")
    end
  end
end

# Test
# Mailer.send_log
