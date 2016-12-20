require 'spec_helper'

describe UsersController do
  describe "GET #show" do
    before(:each) do
      @user = FactoryGirl.create :user
      get :show, id: @user.id, format: :json
    end

    it "returns the information about a reporter on a hash" do
      user_response = json_response
      expect(user_response[:email]).to eql @user.email
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        @user_attributes = FactoryGirl.attributes_for :user
        post :create, {user: @user_attributes}, format: :json
      end

      it "renders the json representation for the user record just created" do
        user_response = json_response
        expect(user_response[:email]).to eql @user_attributes[:email]
        expect(response.headers['Location']).to end_with('users/1')
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        @invalid_user_attributes = {password: "12345678",
                                    password_confirmation: "12345678"}
        post :create, {user: @invalid_user_attributes}, format: :json
      end

      it "renders an error json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
        expect(user_response[:errors][:email]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  describe "PUT #update" do

    context "when is successfully updated" do
      before(:each) do
        @user = FactoryGirl.create :user
        patch :update,
              {id: @user.id,
               user: {email: "new@test.com"}},
              format: :json
      end

      it 'should render the json representation for the updated user' do
        user_response = json_response
        expect(user_response[:email]).to eql 'new@test.com'
      end

      it { should respond_with 200 }
    end

    context "when is not created" do
      before(:each) do
        @user = FactoryGirl.create :user
        patch :update, { id: @user.id,
                         user: { email: "bademail.com" } }, format: :json
      end

      it "renders an errors json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
        expect(user_response[:errors][:email]).to include "is invalid"
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    context 'delete successfully' do
      before(:each) do
        @user = FactoryGirl.create :user
        delete :destroy, { id: @user.id}, format: :json
      end

      it { should respond_with 204}
    end

    # context 'delete not existed user' do
    #   before(:each) do
    #     @user = FactoryGirl.create :user
    #     delete :destroy, { id: @user.id+1}, format: :json
    #   end
    #
    #   it { should respond_with 400}
    # end

  end
end
