require 'spec_helper'

describe OrdersController do
  describe "GET #index" do
    before(:each) do
      current_user = FactoryGirl.create :user
      4.times { FactoryGirl.create :order, user: current_user }
      get :index, user_id: current_user.id
    end

    it "returns 4 order records from the user" do
      orders_response = json_response
      expect(orders_response.size).to eq(4)
    end

    it { should respond_with 200 }
  end

end
