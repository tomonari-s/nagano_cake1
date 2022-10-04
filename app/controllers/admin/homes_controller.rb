class Admin::HomesController < ApplicationController
  
  def top
    if params[:by_customer_orders]
      @orders = Order.where(name: params[:by_customer_orders])
    else
      @orders = Order.page(params[:page])
    end
      @total_amount = 0
  end  
  
private

  def order_params
  params.require(:order).permit(:customer_id, :delivery_address_postal_code, :delivery_address, :delivery_address_name, :payment_method, :delivery_charge, :billing_amount, :status)
  end  
  
end
