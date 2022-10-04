class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @total = 0
    @total_amount = 0
    @name = @order.customer.last_name + @order.customer.first_name
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    @order_details = @order.order_details
    
    @order_details.each do |order_detail|
      if @order.status == "payment_confirmation"
        order_detail.update(making_status:"waiting_for_production")
      end
    end
    redirect_to admin_order_path
  end
  
private

  def order_params
  params.require(:order).permit(:customer_id, :delivery_address_postal_code, :delivery_address, :delivery_address_name, :payment_method, :postage, :billing_amount, :status)
  end

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :is_deleted)
  end

  def order_detail_params
    params.require(:order_detail).permit(:item_id, :order_id, :amount, :purchase_price, :making_status)  
  end
  
end
