require_relative '../aux'
require_relative '../car'
require_relative '../rental'

describe "#build_actions" do
  car = Car.new(price_per_day: 4000, price_per_km: 25)
  rental_params = { start_date: "2018-03-8", end_date: "2018-03-27", distance: 200 }
  rental = Rental.new(car, rental_params)
  it "sets the correct amount for the driver" do
    actions = build_actions(rental.price_and_commissions)
    action = actions.find { |a| a[:who]=="driver"}
    actual = action[:amount]
    expected = 56600

    expect(actual).to eq(expected)
  end

  it "sets the correct amount for the owner" do
    actions = build_actions(rental.price_and_commissions)
    action = actions.find { |a| a[:who]=="owner"}
    actual = action[:amount]
    expected = 39620

    expect(actual).to eq(expected)
  end

  it "sets the correct amount for the insurance" do
    actions = build_actions(rental.price_and_commissions)
    action = actions.find { |a| a[:who]=="insurance"}
    actual = action[:amount]
    expected = 8490

    expect(actual).to eq(expected)
  end

  it "sets the correct amount for the road assistance" do
    actions = build_actions(rental.price_and_commissions)
    action = actions.find { |a| a[:who]=="assistance"}
    actual = action[:amount]
    expected = 2000

    expect(actual).to eq(expected)
  end

  it "sets the correct amount for drivy" do
    actions = build_actions(rental.price_and_commissions)
    action = actions.find { |a| a[:who]=="drivy"}
    actual = action[:amount]
    expected = 6490

    expect(actual).to eq(expected)
  end
end

