require 'java'

require File.dirname(__FILE__) + '/logginator.rb'
require File.dirname(__FILE__) + '/../lib/jtds-1.2.2.jar'

include_class 'net.sourceforge.jtds.jdbc.Driver'

#DOCS: http://jtds.sourceforge.net/doc/net/sourceforge/jtds/jdbc/JtdsResultSet.html

class Database

  attr_accessor :jdbo

  module JavaLang
    include_package "java.lang"
  end

  module JavaSql
    include_package 'java.sql'
  end

  def initialize
    @user = "user"
    @pass = "pass"
    @addr = "server.domain.com"
    @tdb  = "database"
    connect
  end

  def connect
    begin
      Java::NetSourceforgeJtdsJdbc::Driver.new
      # Added 8 hours timeout, to avoid queries from handing
      @jdbo = JavaSql::DriverManager.getConnection("jdbc:jtds:sqlserver://#{@addr}/#{@tdb};user=#{@user};password=#{@pass};socketTimeout=28800")
    rescue JavaLang::ClassNotFoundException => e
      Logginator::fatal e.message
      raise e
    end
  end

  def connected?
    return (not @jdbo.closed?)
  end

  def logout
    @jdbo.close
  end


  def execute(query)
    begin
      connect unless connected?
      stmt = @jdbo.createStatement
      Logginator::info query
      rs = stmt.execute(query)
      return rs
    rescue JavaSql::SQLException => e
      Logginator::fatal e.message
      raise e
    end

  end

  def query(query)
    begin
      connect unless connected?
      stmt = @jdbo.createStatement
      Logginator::info query
      rs = stmt.executeQuery(query)
      result=[]
      while (rs.next) do
        result << rs.getCurrentRow.to_a.dup
      end
      rs.close
      stmt.close
      return result
    rescue JavaSql::SQLException => e
      Logginator::fatal e.message
      raise e
    ensure
      Logginator::info "query total_rows: #{result.size}"
    end
  end
end

# Test
# db = Database.new
# p db.query("select current_timestamp;")

# http://rubylearning.com/blog/2007/05/05/connect-jruby-to-mysql-using-jdbc/
# http://www.petefreitag.com/articles/jdbc_urls/
# http://blogs.sun.com/coolstuff/entry/using_java_classes_in_jruby
# http://wiki.jruby.org/wiki/Calling_Java_from_JRuby
