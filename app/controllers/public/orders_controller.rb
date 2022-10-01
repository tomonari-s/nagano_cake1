class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def comfirm
    
  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    redirect_to public_comfirm_path(@order.id)
  end

  def index
  end

  def show
  end
  
  private
  def order_params
     params.require(:order).permit(:payment_method)
  end
end
