################################
require_relative 'car'
require_relative 'rental'
require_relative 'aux'
################################


data = read_json

cars_data = data[:cars]
rentals_data = data[:rentals]
options_data = data[:options]

rentals_actions = rentals_data.map do |rent|
  car = Car.new(cars_data.find { |c| c[:id] == rent[:car_id] })
  options = options_data.select { |o| o[:rental_id] == rent[:id] }.map{ |o| o[:type] }
  rental = Rental.new({ car: car, start_date: rent[:start_date], end_date: rent[:end_date], distance: rent[:distance], options: options })
  {
    id: rent[:id],
    options: options,
    actions: build_actions(rental.price_commissions_extras)
  }
end

write_json({ rentals: rentals_actions })



