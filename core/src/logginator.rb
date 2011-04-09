
require 'logger'

class Logginator

  attr_accessor :log_stdout, :log_file

  LOG_PATH = File.dirname(__FILE__) + "/../log/log_#{Time.now.strftime("%Y%m%d")}.log"

  def self.create_if_needed
    if @log_file.nil? or @log_stdout.nil?
      @log_stdout = Logger.new(STDERR)
      @log_stdout.level = Logger::INFO
      @log_file = Logger.new(LOG_PATH)
      @log_file.level = Logger::INFO
    end

    return self
  end

  def self.get_log_path
    return LOG_PATH
  end

  def self.info str
    create_if_needed
    @log_file.info str
    @log_stdout.info str
  end

  #alias for the debug
  class << self
    alias :debug :info
  end

  def self.warn str
    create_if_needed
    @log_file.warn str
    @log_stdout.warn str
  end

  def self.fatal str
    create_if_needed
    @log_file.fatal str
    @log_stdout.fatal str
  end

  def self.error str
    create_if_needed
    @log_file.error str
    @log_stdout.error str
  end

end
