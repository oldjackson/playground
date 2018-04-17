################################
require 'json'
require_relative 'car'
require_relative 'rental'
################################
INPUT_PATH = 'data/input.json'
OUTPUT_PATH = 'data/output.json'
################################


data = JSON.parse(File.read(INPUT_PATH), :symbolize_names => true)

cars_data = data[:cars]
rentals_data = data[:rentals]

rentals_prices = rentals_data.map do |rent|
  car = Car.new(cars_data.find { |c| c[:id] == rent[:car_id] })
  rental = Rental.new({ car: car, start_date: rent[:start_date], end_date: rent[:end_date], distance: rent[:distance] })
  {
    id: rent[:id],
    price: rental.price
  }
end

output = { rentals: rentals_prices }

File.open(OUTPUT_PATH, 'wb') do |file|
  file.write(JSON.pretty_generate(output))
end
