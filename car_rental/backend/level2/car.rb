class Car
  def initialize(parameters)
    @price_per_day = parameters[:price_per_day]
    raise ArgumentError.new, "The price per day has to be positive" if @price_per_day < 1
    @price_per_km = parameters[:price_per_km]
    raise ArgumentError.new, "The price per km has to be positive" if @price_per_km < 1
  end

  attr_reader :price_per_day, :price_per_km
end
