
Daily Extract - Extract
=======================

Scripts that automate the process of aggregating data in a database, extracting it, outputting results into csv files and sending them over by sftp.


Structure of application
------------------------

						           
		bin/					-> running the scripts
		lib/                 	-> code lib			
		log/                 	-> outputted logs
		out/                 	-> outputted extracts
		Rakefile             	-> tasks to run
		README               	-> this
		src/					->
			daily.rb			-> to run the extracts on daily base
			extracts/			->
				extract_*.rb	-> individual extracts
			extract.rb			-> main file with extracts logic
			sql/				->
				build_*.sql		-> complex aggregation queries that create new tables
				query_*.sql		-> queries out the new tables
		test/					->
			*_spec.rb			-> tests


## Testing Framework ##

**Running Tests**

*All Examples*

	jruby -S rake tests

*Individual Examples*

	jruby -S spec test/extract_spec.rb --format specdoc

	
**Testing Reference**

http://rspec.rubyforge.org/index.html

	--------------------------------------------------------------------------------------------

	## Running directly from Java ##

	Run a Spec: java -Xmx256m -jar lib/jars/jruby-complete.jar -S spec test/database_spec.rb

	Ruby Version: java -Xmx256m -jar lib/jars/jruby-complete.jar -v -S gem list

	Run All tests: java -Xmx256m -jar lib/jars/jruby-complete.jar -S rake tests

	http://blog.nicksieger.com/articles/2007/01/12/self-cloning-jruby-and-rubygems-in-a-jar

	-----------------------