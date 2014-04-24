require 'spec_helper'

describe Customer do
  context 'initialize' do
    let(:customer) { Customer.new }

    it 'should be valid with name' do
      customer.should_not be_valid
      customer.should have(1).error_on(:first_name)
      customer.should have(1).error_on(:last_name)

      customer.first_name = 'Bob'
      customer.last_name = 'Marley'
      customer.should be_valid
    end
  end

  it 'should have correct name' do
    customer = build(:customer, first_name: 'John', last_name: 'Snow')
    customer.name.should == 'John Snow'
  end
end
