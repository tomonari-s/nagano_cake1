class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    @order = @order_detail.order

    if @order_detail.making_status == "production"
      @order.update(status:"production")

    elsif @order.order_details.count == @order.order_details.where(making_status: "production_completed").count
      @order.update(status:"shipping_preparation")
    end
    redirect_to admin_order_path(@order)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:item_id, :order_id, :amount, :purchase_price, :making_status)
  end

  def order_params
  params.require(:order).permit(:customer_id, :delivery_address_postal_code, :delivery_address, :delivery_address_name, :payment_method, :delivery_charge, :billing_amount, :status)
  end
end
