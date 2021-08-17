class Admin::OrdersController < ApplicationController
  
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    #商品合計
    @total = 0
    @order_items.each do |order_item|
      tol = order_item.item.price * order_item.amount
      @total += tol 
    end
  end
  
  def update
    order = Order.find(params[:id])
    #注文ステータスが"入金確認"になったら製作ステータスを"製作待ち"
    if params[:order][:status] == "b"
      order.order_items.each do |order_item|
        order_item.making_status = "b"
        order_item.update(making_status: order_item.making_status)
      end
    end
    order.update(order_params)
    redirect_to admin_order_path(order)
  end
  
  private
  
  def order_paraems
    params.require(:order).permit(:status)
  end
  
end
