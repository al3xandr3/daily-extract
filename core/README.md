
Daily Extract - Core
====================

Scripts that automate the process of aggregating data in a database, extracting it, outputting results into csv files and sending them over by sftp.

Structure of application
------------------------
 
	bin/            -> 
    lib/            -> jars libs needed
    	*.jar       -> 
    log/            -> log files
    Rakefile        -> 
    README          -> 
    src/            -> code
    	*.rb        -> 
    test/           -> tests
    	*_spec.rb   -> 

Testing Framework
-----------------

### Running Tests

All Examples

	jruby -S rake tests

Individual Examples

	jruby -S spec test/logginator_spec.rb --format specdoc
	jruby -S spec test/mailer_spec.rb --format specdoc
	jruby -S spec test/secureftp_spec.rb --format specdoc
	jruby -S spec test/timeutils_spec.rb --format specdoc		
	jruby -S spec test/database_spec.rb --format specdoc

### Testing Reference

http://rspec.rubyforge.org/index.html
