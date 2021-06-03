class DeliveriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_furima, only: [:index, :create]
  before_action :prevent_url, only: [:index, :create]

  def index
    @user_delivery = UserDelivery.new
  end

  def create
    @user_delivery = UserDelivery.new(delivery_params)
    if @user_delivery.valid?
      pay_item
      @user_delivery.save
      redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def delivery_params
    params.require(:user_delivery).permit(:post_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def set_furima
    @item = Item.find(params[:item_id])
  end

  def prevent_url
    redirect_to root_path if @item.user_id == current_user.id || !@item.buyer.nil?
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: delivery_params[:token],
      currency: 'jpy'
    )
  end
end
