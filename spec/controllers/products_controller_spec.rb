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


  describe 'POST #create' do
    context "when is successfully" do
      before(:each) do
        @user = FactoryGirl.create :user
        @product_attributes = FactoryGirl.attributes_for :product
        post :create, user_id: @user.id, product: @product_attributes
      end

      it 'return created product record' do
        product_response = json_response
        expect(product_response[:title]).to eql @product_attributes[:title]
        expect(response.headers['Location']).to end_with('users/' + @user.id.to_s + '/products/1')
      end

      it { should respond_with 201}
    end
  end

  context "when created failed" do
    before(:each) do
      @user = FactoryGirl.create :user
      @invalid_product_attributes = { title: "Smart TV", price: "Twelve dollars" }
      post :create, user_id: @user.id, product: @invalid_product_attributes
    end

    it "renders an errors json" do
      product_response = json_response
      expect(product_response).to have_key(:errors)
      expect(product_response[:errors][:price]).to include "is not a number"
    end

    it { should respond_with 400 }
  end

  describe 'PUT #update' do
    before(:each) do
      @user = FactoryGirl.create :user
      @product = FactoryGirl.create :product, user: @user
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, { user_id: @user.id, id: @product.id,
                         product: { title: "An expensive TV" } }
      end

      it "renders the json representation for the updated user" do
        product_response = json_response
        expect(product_response[:title]).to eql "An expensive TV"
      end

      it { should respond_with 200 }
    end
  end
end
