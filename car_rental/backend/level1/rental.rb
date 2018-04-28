require 'date'

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
    @car.price_per_day * (@end_date - @start_date + 1).to_i + @car.price_per_km * @distance
  end
end
