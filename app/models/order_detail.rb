class OrderDetail < ApplicationRecord
  has_many :orders
  belongs_to :item
end
