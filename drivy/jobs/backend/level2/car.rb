class Car
  def initialize(parameters)
    @price_per_day = parameters[:price_per_day]
    @price_per_km = parameters[:price_per_km]
  end

  attr_reader :price_per_day, :price_per_km
end
