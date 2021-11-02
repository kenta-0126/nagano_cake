class Public::CartItemsController < ApplicationController
  
  def index
    @cart_items = CartItem.all
    @total = 0
    @cart_items.each do |cart_item| 
      tal = (cart_item.item.price* 1.1).floor * cart_item.amount
      @total += tal
    end
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end
  
  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end
  
  def empty
    CartItem.destroy_all
    flash[:notice] = "カートを空にしました"
    redirect_to cart_items_path
  end
  
  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.save
    redirect_to cart_items_path
  end
  
  private
  
  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end
end
