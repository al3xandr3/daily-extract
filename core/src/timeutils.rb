
require 'rubygems'
require 'erb'

def Time.yesterday; now - 86400; end
def Time.days_ago(x); now - x*86400; end
def Time.days_before(date, x); date - x*86400; end
def Time.day_before(date); date - 86400; end
def Time.day_after(date); date + 86400; end
def Time.days_after(date, x); date + x*86400; end

class Numeric
  # Enables the use of time calculations and declarations, 
  # like 45.minutes + 2.hours + 4.years. The base unit for
  # all of these Numeric time methods is seconds.
  def seconds ; self ; end
  alias_method :second, :seconds
  #def as_seconds ; self ; end

  # Converts minutes into seconds.
  def minutes ; self * 60 ; end
  alias_method :minute, :minutes
  #def as_minutes ; self.to_f / 60 ; end

  # Converts hours into seconds.
  def hours ; self * 60.minutes ; end
  alias_method :hour, :hours
  #def as_hours ; self / 60.minutes ; end

  # Converts days into seconds.
  def days ; self * 24.hours ; end
  alias_method :day, :days
  #def as_days ; self / 24.hours ; end

  # Converts weeks into seconds.
  def weeks ; self * 7.days ; end
  alias_method :week, :weeks
  #def as_weeks ; self / 7.days ; end

  # Converts fortnights into seconds.
  # (A fortnight is 2 weeks)
  def fortnights ; self * 2.weeks ; end
  alias_method :fortnight, :fortnights
  #def as_fortnights ; self / 2.weeks ; end

  # Converts months into seconds.
  # WARNING: This is not exact as it assumes 30 days to a month.
  def months ; self * 30.days ; end
  alias_method :month, :months
  #def as_months ; self / 30.days ; end

  # Converts years into seconds.
  def years ; self * 365.days ; end
  alias_method :year, :years
  #def as_years ; self / 365.days ; end

  # Calculates time _before_ a given time. Default time is now.
  # Reads best with arguments: 10.days.before( Time.now - 1.day )
  def before(time = ::Time.now)
    time - self
  end
  alias_method :until, :before   # Reads best with argument: 10.minutes.until(time)
  alias_method :ago, :before     # Reads best without arguments: 10.minutes.ago

  # Calculates time _after_ a given time. Default time is now.
  # Reads best with argument: 10.minutes.after(time)
  def after(time = ::Time.now)
    time + self
  end
  alias_method :since, :after    # Reads best with argument: 10.minutes.since(time)
  alias_method :from_now, :after # Reads best without arguments: 10.minutes.from_now
  alias_method :later, :after    # Reads best without arguments: 10.minutes.later

end

