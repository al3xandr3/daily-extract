require 'java'

require File.dirname(__FILE__) + '/logginator.rb'
require File.dirname(__FILE__) + '/../lib/jsch-20090106.jar'

include_class 'com.jcraft.jsch.JSch'
include_class 'com.jcraft.jsch.Session'
include_class 'java.util.Properties'

# Docs
# http://www.jcraft.com/jsch/index.html
# example: http://nileshbansal.blogspot.com/2007/07/accessing-files-over-sftp-in-java.html
# StrictHostKey: http://coding.derkeiler.com/Archive/Java/comp.lang.java.programmer/2008-04/msg01417.html
# example: http://www.spindriftpages.net/blog/dave/2007/11/27/sshtools-j2ssh-java-sshsftp-library/

class SecureFTP

  attr_accessor :conn, :session, :retrys, :server_name, :sftp

  $SERVERS_SETTINGS = {
    :serv1 => {:host=>"serv1.domain.com",:user=>"user", :pass=>"pass"},
    :serv2 => {:host=>"serv2.domain.com",:user=>"user", :pass=>"pass"}
  }

  def SecureFTP.do_connect(server_name=:serv1)

	  serv = $SERVERS_SETTINGS[server_name]

    # connect
    conn = JSch.new
    session =  conn.getSession(serv[:user], serv[:host])

    # avoid HostKeyCheck
    conf = Properties.new
    conf.put("StrictHostKeyChecking", "no")
    session.setConfig(conf)

    #authenticate
    session.setPassword(serv[:pass])
    session.connect

    #get sftp
    sftp = session.openChannel("sftp")
    sftp.connect

	return sftp
  end

  def SecureFTP.list(server_name=:serv1)
    begin
	  sftp = do_connect(server_name)
      dir = sftp.ls(".")
      res = dir.collect { |fil| fil.get_longname }
    rescue StandardError => e
      Logginator::fatal e.to_s
	ensure
	  sftp.session.disconnect
    end
  end

  def SecureFTP.send(orig_path, dest_path="", server_name=:serv1)
    begin
	  @retrys = 4 if @retrys.nil?
	  sftp = do_connect(server_name)
      dest_path += "/" unless dest_path==""
      sftp.put(orig_path, dest_path + (orig_path.split("/").last||""))
      Logginator::info "finish uploading: "  + orig_path + " to " + dest_path
    rescue StandardError => e
      Logginator::warn e.to_s + "\n ...trying again..."
      if @retrys > 0
        @retrys -= 1
        send(orig_path, dest_path, server_name)
      else
        Logginator::fatal e.message
        raise StandardError
      end
    ensure
	  sftp.session.disconnect
    end
  end
end

# Examples:
# puts SecureFTP::send("","")