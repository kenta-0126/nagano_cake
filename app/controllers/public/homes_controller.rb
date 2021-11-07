class Public::HomesController < ApplicationController
   
  def top
    @items = Item.all
    @item = Item.limit(4).order(" created_at DESC ")
  end
  
  def about
  end
  
end
