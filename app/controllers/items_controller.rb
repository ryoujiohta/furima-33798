class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  
  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end


  def item_params
    params.require(:item).permit(:name, :price, :description, :image, :category_id, :item_status_id, :prefecture_id,
                                 :delivery_burden_id, :delivery_day_id).merge(user_id: current_user.id)
  end



end
