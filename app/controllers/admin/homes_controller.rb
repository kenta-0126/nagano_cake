class Admin::HomesController < ApplicationController

  def top
    @orders = Order.order("created_at DESC")

  end


end
