require 'date'
################################
DAYS_THRESHOLDS = [1, 4, 10]
THRESH_DISCOUNTS = [10, 30, 50]
COMMISSION_PC = 30
ROAD_ASSIST_PER_DAY = 100
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

  def price_and_commissions
    days = (@end_date - @start_date + 1).to_i
    price = time_price(days) + @car.price_per_km * @distance
    commission = COMMISSION_PC * price / 100
    assist_fee = ROAD_ASSIST_PER_DAY * days

    {
      price: price,
      commission: { insurance_fee: commission / 2, assistance_fee: assist_fee, drivy_fee: commission / 2 - assist_fee }
    }
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
