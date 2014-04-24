# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

$customers = (1..4).map do
  Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
end

CHARGE_TYPES = {failed: {}, successful: {paid: true}, disputed: {paid: true, refunded: true}}
CHARGE_ATTRS = {amount: -> {Random.rand(10000)}, currency: 'usd'}

def seed_charges(type, seed_hash)
  seed_hash.each do |customer_number, count|
    count.times do
      attrs = {}
      CHARGE_ATTRS.each do |name, value|
        attrs[name] = value.kind_of?(Proc) ? value.call : value
      end
      $customers[customer_number - 1].charges.create!(attrs.merge(CHARGE_TYPES[type]))
    end
  end
end

successful_hash = {1 => 5, 2 => 3, 3 => 1, 4 => 1}
seed_charges(:successful, successful_hash)

failed_hash = {3 => 3, 4 => 2}
seed_charges(:failed, failed_hash)

disputed_hash = {1 => 3, 2 => 2}
seed_charges(:disputed, disputed_hash)
