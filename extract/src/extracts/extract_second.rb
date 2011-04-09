
## EXTRACT: Second

class Extract

  def build_second(date_extract=Time.days_ago(1) )
    execute('second', date_extract)
  end

  def query_second(query_nr, date_extract=Time.days_ago(1))
    results = query("second", date_extract)
    fname = File.dirname(__FILE__) + "/../../out/" + "SECOND_"+ date_extract.strftime("%Y%m%d") +".txt"
    output(results, fname, "COL1|COL2|COL3")
    if filesize_is_valid?(fname, (1..6500))
      SecureFTP::send(fname, "/", :serv1)
    else
      serr = "SECOND:#{(10 + query_nr).to_s} is broken for day #{date_extract.strftime("%Y%m%d")}"
      Mailer::send_mail(serr,serr)
    end
  end

  ##
  # runs extract
  def second(date_extract=Time.days_ago(1))
    build_second date_extract
    query_second date_extract
  end

end
