class Item < ApplicationRecord
  has_many :cart_items
  has_many :order_items
  attachment :image
  belongs_to :genre

    enum is_active: { on_sale: 0, off_sale: 1 }

    

  validates :name, {presence: true}
  validates :introduction, {presence: true}
  validates :price, {presence: true}
end
