class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  
  def index
  end

  # def new
  # end

  # def create
  # end

  # def show
  # end

  # def edit
  # end





  
end
