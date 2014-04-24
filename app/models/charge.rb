class Charge < ActiveRecord::Base
  belongs_to :customer

  validates :currency, presence: true
  validates :amount, numericality: {greater_than: 0, less_than: 1000000000}

  scope :successful, -> { where(paid: true, refunded: false) }
  scope :failed, -> { where(paid: false) }
  scope :disputed, -> { where(paid: true, refunded: true) }
end
