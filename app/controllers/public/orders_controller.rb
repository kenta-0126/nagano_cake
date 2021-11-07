class Public::OrdersController < ApplicationController
 before_action :authenticate_customer!
  def new
    @addresses = Address.all
    @orders = Order.all
    @order = Order.new
  end

  def confirm


    @cart_items = current_customer.cart_items
    @total = 0
    @cart_items.each do |cart_item|
      tal = (cart_item.item.price* 1.1).floor* cart_item.amount
      @total += tal
    end
    session[:order] = Order.new()

    session[:order][:payment_method] = params[:order][:payment_method]
    if session[:order][:payment_method] == "credit"
      @payment_method = "クレジットカード"
    elsif session[:order][:payment_method] == "bunk"
      @payment_method = "銀行振込"
    end

    address_pattern = params[:order][:address_select].to_i
    if address_pattern == 0
      session[:order][:postal_code] = current_customer.postal_code
      session[:order][:address] = current_customer.address
      session[:order][:name] = current_customer.full_name

    elsif address_pattern == 1
      session[:order][:postal_code] =  Address.find(params[:order][:address_id]).postal_code
      session[:order][:address] = Address.find(params[:order][:address_id]).address
      session[:order][:name] = Address.find(params[:order][:address_id]).name
    else
      session[:order][:postal_code] =  params[:order][:postal_code]
      session[:order][:address] = params[:order][:address]
      session[:order][:name] = params[:order][:name]

    end

  end

  def thanks
    # order = Order.new
    # order.bill = 1000
    # order.status = 1
    # order.customer_id = current_customer.id
    # order.save
    session[:order][:customer_id] = current_customer.id
     puts session[:order]
    @order = Order.new(session[:order])
    @order.postage = 800
    @order.save
    cart_items = current_customer.cart_items
    cart_items.each do |cart_item|
      order_item = OrderItem.new
      order_item.item_id = cart_item.item.id
      order_item.making_status = 0
      order_item.tax_price = (cart_item.item.price* 1.1).floor
      order_item.amount = cart_item.amount
      order_item.order_id = @order.id
      order_item.save
    end
    cart_items.destroy_all
  end

  def create
    session[:order][:customer_id] = current_customer.id
    puts session[:order]
    @order = Order.new(session[:order])
    @order.postage = 800
    @order.save
    cart_items = current_customer.cart_items
    cart_items.each do |cart_item|
      order_item = OrderItem.new
      order_item.item_id = cart_item.item.id
      order_item.making_status = 0
      order_item.tax_price = (cart_item.item.price* 1.1).floor
      order_item.amount = cart_item.amount
      order_item.order_id = @order.id
      order_item.save
    end
    cart_items.destroy_all
    redirect_to thanks_orders_path

  end

  def index
      @orders = Order.all


  end


  def show
      @order = Order.find(params[:id])
      @order_items = @order.order_items

  end

  private

  def order_params
    params.require(:order).permit(:name, :postal_code, :address, :payment_method, :item_id, :postage, :bill)
  end

end
