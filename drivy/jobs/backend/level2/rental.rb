require 'date'
################################
DAYS_THRESHOLDS = [1,4,10]
THRESH_DISCOUNTS = [10,30,50]
################################

class Rental
  def initialize(parameters)
    @car = parameters[:car]
    @start_date_str = parameters[:start_date]
    @end_date_str = parameters[:end_date]
    @distance = parameters[:distance]
  end

  def price
    start_date = Date.parse(@start_date_str)
    end_date = Date.parse(@end_date_str)
    days = (end_date - start_date + 1).to_i

    time_price(days) + @car.price_per_km * @distance
  end

  private

  def time_price(days)
    padded_threshs = [0] + DAYS_THRESHOLDS + [Float::INFINITY]
    floored_discs = [0] + THRESH_DISCOUNTS

    disc_days = 0
    floored_discs.each_index do |i|
      disc_days += (100 - floored_discs[i]) * ( [padded_threshs[i + 1], [days, padded_threshs[i]].max ].min - padded_threshs[i] )
    end
    @car.price_per_day * disc_days / 100
  end
end
