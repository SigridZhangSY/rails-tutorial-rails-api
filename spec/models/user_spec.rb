require 'spec_helper'

describe User, type: :model do
  before { @user = FactoryGirl.build(:user) }

  subject { @user}

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should validate_presence_of(:email) }
  # it { should validate_uniqueness_of(:email) }
  it { should validate_confirmation_of(:password) }
  it { should allow_value('example@domain.com').for(:email) }
  it { should have_many(:product) }

  describe "#products association" do

    before do
      @user.save
      3.times { FactoryGirl.create :product, user: @user }
    end

    it "destroys the associated products on self destruct" do
      products = @user.product
      @user.destroy
      products.each do |product|
        expect(Product.find(product)).to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
