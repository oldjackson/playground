require_relative '../aux'
require_relative '../car'
require_relative '../rental'

describe "#build_actions" do
  car = Car.new(price_per_day: 4000, price_per_km: 25)
  rental_params = { start_date: "2018-03-8", end_date: "2018-03-27", distance: 200 }

  options = ["gps", "baby_seat", "additional_insurance"]
  rental = Rental.new(car, rental_params, options)

  it "sets the correct amount for the driver" do
    actions = build_actions(rental.price_commissions_extras)
    action = actions.find { |a| a[:who]=="driver"}
    actual = action[:amount]
    expected = 90600

    expect(actual).to eq(expected)
  end

  it "sets the correct amount for the owner" do
    actions = build_actions(rental.price_commissions_extras)
    action = actions.find { |a| a[:who]=="owner"}
    actual = action[:amount]
    expected = 53620

    expect(actual).to eq(expected)
  end

  it "sets the correct amount for the insurance" do
    actions = build_actions(rental.price_commissions_extras)
    action = actions.find { |a| a[:who]=="insurance"}
    actual = action[:amount]
    expected = 8490

    expect(actual).to eq(expected)
  end

  it "sets the correct amount for the road assistance" do
    actions = build_actions(rental.price_commissions_extras)
    action = actions.find { |a| a[:who]=="assistance"}
    actual = action[:amount]
    expected = 2000

    expect(actual).to eq(expected)
  end

  it "sets the correct amount for letmedrive" do
    actions = build_actions(rental.price_commissions_extras)
    action = actions.find { |a| a[:who]=="letmedrive"}
    actual = action[:amount]
    expected = 26490

    expect(actual).to eq(expected)
  end
end

