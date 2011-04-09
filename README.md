
Daily Extract
=============

Scripts that automate the process of aggregating data in a database, extracting it, outputting results into csv files and sending them over by sftp.

In 2 parts:

core - containing the core utils for: database(jdatabase.rb), sftp(jsecureftp.rb), logging(logginator.rb) and mail sender(mailer.rb).

extract - assembles all core components into an Extract class. Adds a task list queue(keeping all tasks needed todo serialize to file), outputting extracts, assertions for assuring valid extractions, sending mail on fail, logging full execution(including sql executed code), sending email on extract success(attaching the log), sql templating(mainly for updating the date range of the extractions) 

Also, the Daily Extract follows strongly the idea of convention over configuration to make it easier to add new extracts. For example, for an extract called: [first], we will have:
 - src/sql/build_[first].sql, that aggregates(builds) data for being extracted.
 - src/sql/query_[first].sql, that extracts(queries) the data out from database.   
 - src/extracts/extract_[first].rb, containing a method [first] that will execute all steps.

Then just add "first" into the daily.rb extracts list and the whole extract will be queued properly and executed together with the existing ones.



The original version was build using (C)ruby, but at some point i changed to  (JVM)jruby instead, no big changes from original code, but allowed me to use sftp and the db connector(both JVM libs) improving portability.

Not actively maintained, and build in 2007,2008.