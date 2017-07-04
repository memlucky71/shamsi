module Shamsi
  module Algorithm
    def get_julian_day_from_gregorian_date(year, month, day)
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

    end
  end
end