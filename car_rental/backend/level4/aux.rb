################################
require 'json'
################################
INPUT_PATH = 'data/input.json'
OUTPUT_PATH = 'data/output.json'
################################


def read_json
  JSON.parse(File.read(INPUT_PATH), symbolize_names: true)
end

def write_json(output)
  File.open(OUTPUT_PATH, 'wb') do |file|
    file.write(JSON.pretty_generate(output))
  end
end

def build_actions(amounts)
  [
    {
      who: "driver",
      type: "debit",
      amount: amounts[:price]
    },
    {
      who: "owner",
      type: "credit",
      amount: amounts[:price] - amounts[:commission].values.reduce(:+)
    },
    {
      who: "insurance",
      type: "credit",
      amount: amounts[:commission][:insurance_fee]
    },
    {
      who: "assistance",
      type: "credit",
      amount: amounts[:commission][:assistance_fee]
    },
    {
      who: "letmedrive",
      type: "credit",
      amount: amounts[:commission][:letmedrive_fee]
    }
  ]
end
