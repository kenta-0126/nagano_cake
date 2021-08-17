class Order < ApplicationRecord
  has_many :order_items 
  
  
  belongs_to :customer
  
  enum payment_method: { credit: 0, bunk: 1 }
  enum status: { a: 0, b: 1, c: 2, d: 3, e: 4 }
end
