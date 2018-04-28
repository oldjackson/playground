require_relative '../car'

describe Car do
  describe "#initialize" do
    it "should raise an argument error if passed a price_per_day below 1" do
      expect { Car.new(price_per_day: -100, price_per_km: 20) }.to raise_error ArgumentError
    end
    it "should raise an argument error if passed a price_per_km below 1" do
      expect { Car.new(price_per_day: 3000, price_per_km: 0) }.to raise_error ArgumentError
    end
  end

  car = Car.new(price_per_day: 3000, price_per_km: 17)

  describe "#price_per_day" do
    it "returns the correct price per day" do

      actual = car.price_per_day
      expected = 3000

      expect(actual).to eq(expected)
    end
  end

  describe "#price_per_km" do
    it "returns the correct price per km" do

      actual = car.price_per_km
      expected = 17

      expect(actual).to eq(expected)
    end
  end
end
