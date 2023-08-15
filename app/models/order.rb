class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy

  enum payment_status: { クレジットカード: 0, 銀行振込: 1 }
end
