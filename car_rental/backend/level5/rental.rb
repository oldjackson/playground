require 'date'
################################
DAYS_THRESHOLDS = [1, 4, 10]
THRESH_DISCOUNTS = [10, 30, 50]
COMMISSION_PC = 30
ROAD_ASSIST_PER_DAY = 100
OPTIONS_DAILY_FLOWS = {
  "gps" => { daily_price: 500, beneficiary: "owner" },
  "baby_seat" => { daily_price: 200, beneficiary: "owner" },
  "additional_insurance" => { daily_price: 1000, beneficiary: "letmedrive" }
}
################################

class Rental
  def initialize(car, rental_parameters, options = [])
    @car = car
    @start_date = Date.parse(rental_parameters[:start_date])
    @end_date = Date.parse(rental_parameters[:end_date])
    raise ArgumentError.new, "The end date cannot precede the start date" if @start_date > @end_date
    @distance = rental_parameters[:distance]
    raise ArgumentError.new, "The distance cannot be negative" if @distance < 0
    @options = options
  end

  def price_commissions_extras
    days = (@end_date - @start_date + 1).to_i
    price = time_price(days) + @car.price_per_km * @distance
    commission = COMMISSION_PC * price / 100
    assistance_fee = ROAD_ASSIST_PER_DAY * days
    extra_flows = options_flows(days)

    {
      price: price + extra_flows.values.reduce(:+),
      commission: {
        insurance_fee: commission / 2,
        assistance_fee: assistance_fee,
        letmedrive_fee: commission / 2 - assistance_fee
      },
      extras: extra_flows
    }
  end

  private

  def time_price(days)
    padded_threshs = [0] + DAYS_THRESHOLDS + [Float::INFINITY]
    floored_discs = [0] + THRESH_DISCOUNTS

    disc_days = 0
    floored_discs.each_index do |i|
      disc_days +=
        (100 - floored_discs[i]) * ([padded_threshs[i + 1], [days, padded_threshs[i]].max].min - padded_threshs[i])
    end
    @car.price_per_day * disc_days / 100
  end

  def options_flows(days)
    daily_flow_to_owner = OPTIONS_DAILY_FLOWS.select { |k, v| @options.include?(k) && v[:beneficiary] == "owner" }
    daily_flow_to_lmd = OPTIONS_DAILY_FLOWS.select { |k, v| @options.include?(k) && v[:beneficiary] == "letmedrive" }
    {
      owner: daily_flow_to_owner.empty? ? 0 : daily_flow_to_owner.values.map { |v| v[:daily_price] }.reduce(:+) * days,
      letmedrive: daily_flow_to_lmd.empty? ? 0 : daily_flow_to_lmd.values.map { |v| v[:daily_price] }.reduce(:+) * days
    }
  end
end
