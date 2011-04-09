
require File.dirname(__FILE__) + '/extract.rb'

require 'yaml'

class DailyExtract

  def self.run

    begin
      queue_file =  File.dirname(__FILE__) + '/../todo.queue'
      @queue = queue_load queue_file

      #########
      ## BUILDS
      #
      yesterday_date = Time.days_ago(1).strftime("%Y-%m-%d")

      all_extracts = ["first","second"]

      all_extracts.each do |extract_name|
        @queue.push("@extract.#{extract_name} Time.parse(\"#{yesterday_date}\")")
      end

      # saves the todo list
      queue_unload @queue, queue_file

      # start engines, try to connect to database
      @extract = Extract.new

      while @queue.size>0 do
        command = @queue.shift
        begin
          eval(command)
          #after each sucessfull queued item executed, updates the file
          queue_unload @queue, queue_file
        rescue StandardError => e
          # something went wrong, queue it again
          @queue = [command] + @queue # to put as first
          raise e #to be catched down there
        end
      end

      #reaching here, it means that it got to the end of queue,
      #so will clean the tables to make sure there's enought space.
      @extract.clean_tables

    rescue StandardError => e
      Logginator::error e.message
      Logginator::error e.backtrace.join("\n")
    ensure
      queue_unload @queue, queue_file
      Mailer::send_log("extraction on #{Time.days_ago(1).strftime("%Y-%m-%d")}")
    end
  end

end

# Test
# DailyExtract::run
