require_relative '../rental'

describe Rental do
  car = Car.new(price_per_day: 4000, price_per_km: 25)

  describe "#initialize" do
    it "should raise an argument error if passed inconsistent dates" do
      rental_params = { start_date: "2018-02-8", end_date: "2018-02-", distance: 200 }
      expect { Rental.new(car, rental_params) }.to raise_error ArgumentError
    end
    it "should raise an argument error if passed a negative distance" do
      rental_params = { start_date: "2018-03-8", end_date: "2018-03-10", distance: -200 }
      expect { Rental.new(car, rental_params) }.to raise_error ArgumentError
    end

    rental_params = { start_date: "2018-03-8", end_date: "2018-03-10", distance: 200 }
    rental = Rental.new(car, rental_params)

    it 'should store the Car in an instance variable' do
      expect(rental
        .instance_variable_get(:@car))
        .to be_a Car
    end
  end


  describe "#price" do
    rental_params = { start_date: "2018-03-8", end_date: "2018-03-10", distance: 200 }
    rental = Rental.new(car, rental_params)
    it "returns the correct rental price" do

      actual = rental.price
      expected = 17000

      expect(actual).to eq(expected)
    end
  end
end
