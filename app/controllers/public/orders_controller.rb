class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def comfirm
    
    @order = Order.new(order_params)
    @cart_items = CartItem.all
    @delivery = Delivery.find(params[:order][:delivery_id])
    @order.delivery_charge = 800
    @order.billing_amount = @total.to_i + @order.delivery_charge
    
    
    if params[:order][:select_address] == "0"
        @order.delivery_address_postal_code = current_customer.postal_code
        @order.delivery_address = current_customer.address
        @order.delivery_address_name = current_customer.last_name + current_customer.first_name

    elsif params[:order][:select_address] == "1"
        @order.delivery_address_postal_code = @delivery.postal_code
        @order.delivery_address = @delivery.address
        @order.delivery_address_name = @delivery.name

    elsif params[:order][:select_address] == "2"
        @order.delivery_address_postal_code = params[:order][:postal_code]
        @order.delivery_address = params[:order][:address]
        @order.delivery_address_name = params[:order][:name]
    end    
  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    
    current_customer.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      # @order_detail.production_status = OrderDetail.production_statuses.key(0)
      @order_detail.amount = cart_item.amount
      @order_detail.purchase_price = cart_item.item.price * 1.1
      @order_detail.item_id = cart_item.item_id

      @order_detail.save!
    end
    
    current_customer.cart_items.destroy_all
    redirect_to complete_path
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end
  
  private
  def order_params
    params.require(:order).permit(:customer_id, :payment_method, :delivery_address_postal_code, :delivery_address, :delivery_address_name, :billing_amount, :status, :delivery_charge)
  end
  
  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end
  
  def order_detail_params
    params.require(:order_detail).permit(:item_id, :order_id, :amount, :tax_included_price, :production_status)
  end

end
