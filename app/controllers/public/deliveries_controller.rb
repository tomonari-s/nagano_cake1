class Public::DeliveriesController < ApplicationController
  def index
    @deliveries = Delivery.all
    # @delivery = Delivery.find(params[:id])
  end

  def edit
  end

  def create
    @delivery = Delivery.new(genre_params)
    @delivery.save
    redirect_to public_deliveries_path
  end

  def update
  end

  def destroy
  end
end
