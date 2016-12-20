require 'spec_helper'

describe ProductsController do
  describe 'GET #show' do
    context 'get product successfully' do
      before(:each) do
        @product = FactoryGirl.create :product
        user = FactoryGirl.create :user
        get :show, user_id:user.id,  id: @product.id
      end

      it "return information about a product" do
        product_response = json_response
        expect(product_response[:title]).to eql @product.title
      end

      it {should respond_with 200}
    end

    context 'get product failed' do
      before(:each) do
        @product = FactoryGirl.create :product
        user = FactoryGirl.create :user
        get :show, user_id:user.id, id: @product.id+1
      end

      it {should respond_with 200}
    end
  end

  describe 'GET #index' do
    before(:each) do
      4.times { FactoryGirl.create :product }
      user = FactoryGirl.create :user
      get :index, user_id:user.id
    end

    it "returns 4 records from the database" do
      products_response = json_response
      expect(products_response.size).to eq(4)
    end

    it { should respond_with 200 }

  end
end
