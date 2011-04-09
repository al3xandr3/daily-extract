
require File.dirname(__FILE__) + "/../lib/core-lib.rb"
require 'time'

class Extract

  $TablesClean = []

  def initialize
    @db = Database.new
    @data_uptodate = false
  end

  def execute(name, date_extract=Time.days_ago(1))
    begin
      f = File.open(File.dirname(__FILE__) +"/sql/build_" + name + ".sql")
      query = ERB.new(f.read).result(binding)
      Logginator::info "building " + name
      @db.execute(query)
      return true
    rescue StandardError => e
      raise e # so it can go up to main executer
    end
  end

  def query(name, date_extract=Time.days_ago(1))
    begin
      f = File.open(File.dirname(__FILE__) + "/sql/query_" + name + ".sql")
      query = ERB.new(f.read).result(binding)
      Logginator::info "querying " + name
      results = @db.query(query)
      return results
    rescue StandardError => e
      raise e # so it can go up to main executer
    end
  end

  def output(results, output_file, the_header)
    fil = File.new(output_file, "w+")
    fil.puts the_header
    results.each do |line|
      fil.puts line.join('|')
    end
    fil.puts("#END#")
    fil.close
  end

  def clean_tables(tables_to_clean=$TablesClean)
    begin
      #find the tables
      tables_to_clean.each do |tbl|
        @table_name  = tbl
        f = File.open(File.dirname(__FILE__) +"/sql/query_existing_tables.sql")
        query = ERB.new(f.read).result(binding)
        results = @db.query(query)
        results.each do |full_name|
          @table_full_name = "TABLE." + full_name.to_s
          f = File.open(File.dirname(__FILE__) +"/sql/build_drop_table.sql")
          puts quer = ERB.new(f.read).result(binding)
          @db.execute(quer) unless $TESTING
        end
      end
      return true #signaling success
    rescue Exception => e
      raise e # so it can go up to main executer
    end
  end

  def filesize_is_valid?(fname, range)
    raise "File does not exist" unless File.exists?(fname)
    lnumbers = File.open(fname).readlines.size
    return lnumbers.between?(range.min, range.max)
  end
end

#### Queue Utils ###
def queue_unload(queue, fname)
  File.open(fname, "w+") do |f|
    YAML.dump(queue.uniq, f)
  end
end

def queue_load(fname)
  if File.exists? fname
    File.open(fname) do |f|
      return YAML.load(f)
    end
  else
    return Array.new
  end
end


#include all src/extracts/extract_*
Dir["#{File.dirname(__FILE__)}/extracts/extract_*rb"].each do |extract_path|
 require extract_path
end
