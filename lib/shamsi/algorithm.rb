module Shamsi
  module Algorithm
    def self.get_julian_day_from_gregorian_date(year, month, day)
      is_leap = false
      if year / 4.0 == (year / 4.0).round
        if year / 100.0 == (year / 100.0).round
          if year / 400.0 == (year / 400.0).round
            is_leap = true
          end
        else
          is_leap = true
          end
      end

      if month == 2
        max_days = is_leap ? 29 : 28
        if day > max_days
            raise Exception("Invalid day: #{day}, it must be <= #{max_days}")
        end
      end

      year = year.to_f
      month = month.to_f
      day = day.to_f

      # Determine JD
      if month <= 2
        year -= 1
        month += 12
      end

      century = (year / 100).floor

      return (365.25 * (year + 4716)).floor +
        (30.6001 * (month + 1)).floor +
        day +
        (2 - century + (century / 4).floor) -
        1524.5
    end

    def is_jalali_leap_year?(year)
      subtracted_year = year > 0 ? 474 : 473
      return ((((((year - subtracted_year) % 2820) + 474) + 38) * 682) % 2816) < 682
    end

    def get_days_in_jalali_year(year)
      is_jalali_leap_year?(year) ? 366 : 365
    end

    def self.get_days_in_jalali_month(year, month)
      if month > 12
        raise Exception('Month must be between 1 and 12')
      end

      if 1 <= month and month <= 6
        return 31
      elsif 7 <= month and month < 12
        return 30
      end

      # Esfand(اسفند)
      if is_jalali_leap_year?(year)
        return 30
      else
        return 29
      end
    end

    def self.get_julian_day_from_jalali_date(year, month, day)
      subtracted_year = year >= 0 ? 474 : 473
      base = year - subtracted_year
      julian_year = 474 + (base % 2820)
      added_days = month <= 7 ? (month - 1) * 31 : ((month - 1) * 30) + 6
      return day + added_days + (((julian_year * 682) - 110) / 2816).floor + (julian_year - 1) * 365 +
          (base / 2820).floor * 1029983 + (1948320.5 - 1)
    end

    def self.get_jalali_date_from_julian_day(julian_day)
      julian_day = julian_day.floor + 0.5
      offset = julian_day - 2121445.5  # julian_day_from_jalali(475, 1, 1) replaced by its static value
      cycle = (offset / 1029983).floor
      remaining = offset % 1029983

      if remaining == 1029982
        year_cycle = 2820
      else
        a1 = (remaining / 366).floor
        a2 = remaining % 366
        year_cycle = (((2134 * a1) + (2816 * a2) + 2815) / 1028522).floor + a1 + 1
      end

      y = year_cycle + (2820 * cycle) + 474
      if y <= 0
        y -= 1
      end

      days_in_years = (julian_day - get_julian_day_from_jalali_date(y, 1, 1)) + 1
      m = days_in_years <= 186 ? (days_in_years / 31).ceil : ((days_in_years - 6) / 30).ceil
      day = (julian_day - get_julian_day_from_jalali_date(y, m, 1)).to_i + 1
      return y, m, day
    end

    def get_gregorian_date_from_julian_day(jd)
      y = 0
      m = 0

      if jd <= 0.0
        raise Exception('Invalid Date')
      end

      jdm = jd + 0.5
      z = jdm.floor
      f = jdm - z

      alpha = ((z - 1867216.25) / 36524.25).floor
      b = (z + 1 + alpha - (alpha / 4).floor) + 1524
      c = ((b - 122.1) / 365.25).floor
      d = (365.25 * c).floor
      e = ((b - d) / 30.6001).floor
      day = b - d - floor(30.6001 * e) + f

      if e < 14
        m = e - 1
      elsif e == 14 or e == 15
        m = e - 13
      end

      if m > 2
        y = c - 4716
      elsif m == 1 or m == 2
        y = c - 4715
      end

      return y.to_i, m.to_i, day.to_i

    end

    def get_jalali_date_from_gregorian_date(year, month, day)
      return get_jalali_date_from_julian_day(get_julian_day_from_gregorian_date(year, month, day))
    end

  end
end