require 'spec_helper'

feature 'Charges' do
  context 'GET index' do
    scenario 'should be on right page' do
      visit root_path
      page.title.should eql('Charges')
    end

    context 'with factories' do
      context 'all' do
        given!(:failed_charges) { (1..5).map { create(:charge) } }
        given!(:successful_charges) { (1..10).map { create(:charge, :successful) } }
        given!(:disputed_charges) { (1..5).map { create(:charge, :disputed) } }

        scenario 'list charges' do
          visit root_path

          within '.failed' do
            page.all('tr').count.should eql(5)
          end
          within '.successful' do
            page.all('tr').count.should eql(10)
          end
          within '.disputed' do
            page.all('tr').count.should eql(5)
          end
        end
      end

      shared_examples 'a charge' do
        given!(:charge) { create(:charge) }

        scenario 'should be on right place' do
          visit root_path

          within(charge_scope + ' tr') do
            find('.name').should have_content(charge.customer.name)
            find('.amount').should have_content('$%s' % (charge.amount / 100.0))
            find('.created').should have_content(charge.created_at.to_s(:long))
          end
        end
      end

      context 'failed' do
        it_behaves_like 'a charge' do
          given(:charge_scope) { '.failed' }
          given!(:charge) { create(:charge) }
        end
      end

      context 'successful' do
        it_behaves_like 'a charge' do
          given(:charge_scope) { '.successful' }
          given!(:charge) { create(:charge, :successful) }
        end
      end

      context 'disputed' do
        it_behaves_like 'a charge' do
          given(:charge_scope) { '.disputed' }
          given!(:charge) { create(:charge, :disputed) }
        end
      end
    end
  end
end
