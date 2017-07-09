require 'date'
require_relative 'constants'
require_relative 'algorithm'

module Shamsi
  class Date
    attr_accessor :year, :month, :day

    def initialize(year=1, month=1, day=1, julian_day=nil)
      if year.is_a? Date
        jd = year
        year = jd.year
        month = jd.month
        day = jd.day

      elsif year.is_a? ::Date
        julian_day = Shamsi::Algorithm::get_julian_day_from_gregorian_date(year.year, year.month, year.day)
      end

      if julian_day != nil
          year, month, day = Shamsi::Algorithm::get_jalali_date_from_julian_day(julian_day)
      end

      @year, @month, @day = Date._validate(year, month, day)
    end

    def is_leap?
      return is_jalali_leap_year?(@year)
    end

    def days_in_month
      return get_days_in_jalali_month(@year, @month)
    end

    def self.formatter_factory(fmt)
      return JalaliDateFormatter(fmt)
    end

    def self.today
      return DateTime.now
    end

    def self.from_timestamp(timestamp)
      return DateTime.strptime(timestamp,'%s')
    end




    def self._validate(year, month, day)
      min_year = Shamsi::Constants::MINYEAR
      max_year = Shamsi::Constants::MAXYEAR

      year = year.is_a?(Integer) ? year : year.to_i
      month = month.is_a?(Integer) ? month : month.to_i
      day = day.is_a?(Integer) ? day : day.to_i

      if year < min_year or year > max_year
        raise Exception("Year must be between #{min_year} and #{max_year}, but it is: #{year}")
      end

      if month < 1 or month > 12
        raise Exception("Month must be between 1 and 12, but it is: #{month}")
      end

      _days_in_month = Shamsi::Algorithm::get_days_in_jalali_month(year, month)
      if day < 1 or day > _days_in_month
        raise Exception("Day must be between 1 and #{_days_in_month}, but it is: #{day}")
      end

      return year, month, day
    end
  end

end