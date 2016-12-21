class Order < ActiveRecord::Base
  belongs_to :user

  before_validation :set_total!

  validates :total, presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  validates :user_id, presence: true

  has_many :placements
  has_many :product, through: :placements

  def set_total!
    self.total = product.map(&:price).sum
  end
end
