require_relative '../rental'

describe Rental do
  car = Car.new(price_per_day: 4000, price_per_km: 25)

  describe "#initialize" do
    it "should raise an argument error if passed inconsistent dates" do
      rental_params = { start_date: "2018-02-8", end_date: "2018-02-6", distance: 200 }
      expect { Rental.new(car, rental_params) }.to raise_error ArgumentError
    end
    it "should raise an argument error if passed a negative distance" do
      rental_params = { start_date: "2018-03-8", end_date: "2018-03-10", distance: -200 }
      expect { Rental.new(car, rental_params) }.to raise_error ArgumentError
    end

    rental_params = { start_date: "2018-03-8", end_date: "2018-03-8", distance: 200 }
    rental = Rental.new(car, rental_params)

    it 'should store the Car in an instance variable' do
      expect(rental
        .instance_variable_get(:@car))
        .to be_a Car
    end
  end

  describe "#price_and_commissions" do
    rental_params = { start_date: "2018-03-8", end_date: "2018-03-8", distance: 200 }
    rental = Rental.new(car, rental_params)
    it "returns the correct rental price for 1 day" do

      actual = rental.price_and_commissions[:price]
      expected = 9000

      expect(actual).to eq(expected)
    end

    it "returns the correct rental price for 3 days" do
      rental_params = { start_date: "2018-03-8", end_date: "2018-03-10", distance: 200 }
      rental = Rental.new(car, rental_params)

      actual = rental.price_and_commissions[:price]
      expected = 16200

      expect(actual).to eq(expected)
    end

    it "returns the correct rental price for 7 days" do
      rental_params = { start_date: "2018-03-8", end_date: "2018-03-14", distance: 200 }
      rental = Rental.new(car, rental_params)

      actual = rental.price_and_commissions[:price]
      expected = 28200

      expect(actual).to eq(expected)
    end

    it "returns the correct rental price for 20 days" do
      rental_params = { start_date: "2018-03-8", end_date: "2018-03-27", distance: 200 }
      rental = Rental.new(car, rental_params)

      actual = rental.price_and_commissions[:price]
      expected = 56600

      expect(actual).to eq(expected)
    end

    it "returns the correct total commission" do
      rental_params = { start_date: "2018-03-8", end_date: "2018-03-27", distance: 200 }
      rental = Rental.new(car, rental_params)

      actual = rental.price_and_commissions[:commission].values.reduce(:+)
      expected = 16980

      expect(actual).to eq(expected)
    end

    it "returns the correct insurance fee" do
      rental_params = { start_date: "2018-03-8", end_date: "2018-03-27", distance: 200 }
      rental = Rental.new(car, rental_params)

      actual = rental.price_and_commissions[:commission][:insurance_fee]
      expected = 8490

      expect(actual).to eq(expected)
    end

    it "returns the correct assistance fee" do
      rental_params = { start_date: "2018-03-8", end_date: "2018-03-27", distance: 200 }
      rental = Rental.new(car, rental_params)

      actual = rental.price_and_commissions[:commission][:assistance_fee]
      expected = 2000

      expect(actual).to eq(expected)
    end

    it "returns the correct letmedrive fee" do
      rental_params = { start_date: "2018-03-8", end_date: "2018-03-27", distance: 200 }
      rental = Rental.new(car, rental_params)

      actual = rental.price_and_commissions[:commission][:letmedrive_fee]
      expected = 6490

      expect(actual).to eq(expected)
    end

  end
end
