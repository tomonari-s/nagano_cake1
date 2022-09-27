class Public::CartItemsController < ApplicationController
  def index
    # @cart_items = Cart_item.all
  end

  def update
  end

  def destroy
  end

  def destroy_all
  end

  def create
    binding.pry
    @cart_item = Cart_item.new(genre_params)
    @cart_item.save
    redirect_to '/admin/genres'
  end
  
  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end
end
