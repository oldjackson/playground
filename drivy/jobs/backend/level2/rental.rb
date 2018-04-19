require 'date'
################################
DAYS_THRESHOLDS = [1, 4, 10]
THRESH_DISCOUNTS = [10, 30, 50]
################################

class Rental
  def initialize(car, rental_parameters)
    @car = car
    @start_date = Date.parse(rental_parameters[:start_date])
    @end_date = Date.parse(rental_parameters[:end_date])
    raise ArgumentError.new, "The end date cannot precede the start date" if @start_date > @end_date
    @distance = rental_parameters[:distance]
    raise ArgumentError.new, "The distance cannot be negative" if @distance < 0
  end

  def price
    days = (@end_date - @start_date + 1).to_i

    time_price(days) + @car.price_per_km * @distance
  end

  private

  def time_price(days)
    padded_threshs = [0] + DAYS_THRESHOLDS + [Float::INFINITY]
    floored_discs = [0] + THRESH_DISCOUNTS

    disc_days = 0
    floored_discs.each_index do |i|
      disc_days +=
        (100 - floored_discs[i]) * ([padded_threshs[i + 1], [days, padded_threshs[i]].max].min - padded_threshs[i])
    end
    @car.price_per_day * disc_days / 100
  end
end
