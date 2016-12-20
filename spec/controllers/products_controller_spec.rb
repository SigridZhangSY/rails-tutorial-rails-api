require 'spec_helper'

describe ProductsController do
  describe 'GET #show' do
    context 'get product successfully' do
      before(:each) do
        @product = FactoryGirl.create :product
        get :show, id: @product.id
      end

      it "return information about a product" do
        product_response = json_response
        expect(product_response[:title]).to eql @product.title
      end

      it {should respond_with 200}
    end
  end

end
