require 'spec_helper'

describe ChargesController do
  context 'GET index' do
    let!(:charges) { (1..2).map { create(:charge, :successful) } }

    it 'should assign @charges' do
      get :index

      assigns[:charges].should == charges
    end

    it 'render index template' do
      get :index

      expect(response).to render_template('index')
    end
  end
end
