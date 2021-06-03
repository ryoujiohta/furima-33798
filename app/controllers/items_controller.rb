class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:edit, :show, :update, :destroy]
  before_action :prevent_url, only: [:edit, :update, :destroy]

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

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :description, :image, :category_id, :condition_id, :prefecture_id,
                                 :burden_id, :area_id).merge(user_id: current_user.id)
  end

  # show,edit,update,destroyでの記載まとめ用
  def set_item
    @item = Item.find(params[:id])
  end

  # edit,update,destroyでの記載まとめ用
  def prevent_url
    redirect_to root_path
    if @item.user_id != current_user.id || !@item.buyer.nil?
    end
  end
end
