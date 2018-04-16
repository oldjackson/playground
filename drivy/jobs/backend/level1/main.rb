require 'json'
require 'date'

def rental_price(price_per_day, price_per_km, start_date_str, end_date_str, distance)
  start_date = Date.parse(start_date_str)
  end_date = Date.parse(end_date_str)
  price_per_day * (end_date - start_date + 1).to_i + price_per_km * distance
end

input_path = 'data/input.json'

cars_and_rentals = JSON.parse(File.read(input_path))

cars = cars_and_rentals["cars"]
rentals = cars_and_rentals["rentals"]

rentals_prices = rentals.map do |rent|
  car = cars.find { |c| c["id"] == rent["car_id"] }
  prc = rental_price(car["price_per_day"], car["price_per_km"], rent["start_date"], rent["end_date"], rent["distance"])
  {
    id: rent["id"],
    price: prc
  }
end
output = { rentals: rentals_prices }

output_path = 'data/output.json'

File.open(output_path, 'wb') do |file|
  file.write(JSON.pretty_generate(output))
end
