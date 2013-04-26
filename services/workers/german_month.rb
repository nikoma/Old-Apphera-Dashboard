#!ruby19
# encoding: utf-8

module GermanMonth
  def german_month_to_int(month)
          months = %w(Januar Februar März April Mai Juni July August September Oktober November Dezember)
          i = months.index month
         return i + 1
        end
end