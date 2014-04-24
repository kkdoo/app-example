require 'spec_helper'

describe Charge do
  context 'initialize' do
    let(:charge) { Charge.new }

    it 'should have right default values' do
      charge.paid.should == false
      charge.refunded.should == false
    end

    context 'should be valid with' do
      it 'amount' do
        charge.should_not be_valid
        charge.should have(1).error_on(:amount)
        charge.amount = 999
        charge.should have(0).errors_on(:amount)
      end

      it 'currency' do
        charge.should_not be_valid
        charge.should have(1).error_on(:currency)
        charge.currency = 'usd'
        charge.should have(0).errors_on(:currency)
      end

      it 'amount range' do
        charge.amount = 0
        charge.should have(1).errors_on(:amount)
        charge.amount = -1
        charge.should have(1).errors_on(:amount)
        charge.amount = 1000000000
        charge.should have(1).errors_on(:amount)
        charge.amount = Random.rand(999999999) + 1
        charge.should have(0).errors_on(:amount)
      end
    end
  end

  context 'scope' do
    let(:customer) { create(:customer) }
    let!(:failed_charges) { (1..2).map { create(:charge, customer: customer) } }
    let!(:successful_charges) { (1..3).map { create(:charge, :successful, customer: customer) } }
    let!(:disputed_charges) { (1..4).map { create(:charge, :disputed, customer: customer) } }

    it 'failed' do
      Charge.failed.count.should == 2
    end

    it 'successful' do
      Charge.successful.count.should == 3
    end

    it 'disputed' do
      Charge.disputed.count.should == 4
    end
  end
end
