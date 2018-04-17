################################
require_relative 'car'
require_relative 'rental'
require_relative 'aux'
################################


data = read_json

cars_data = data[:cars]
rentals_data = data[:rentals]

rentals_actions = rentals_data.map do |rent|
  car = Car.new(cars_data.find { |c| c[:id] == rent[:car_id] })
  rental = Rental.new({ car: car, start_date: rent[:start_date], end_date: rent[:end_date], distance: rent[:distance] })
  {
    id: rent[:id],
    actions: build_actions(rental.price_and_commissions)
  }
end

write_json({ rentals: rentals_actions })



