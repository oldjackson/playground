require 'date'

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
    @car.price_per_day * (end_date - start_date + 1).to_i + @car.price_per_km * @distance
  end
end
