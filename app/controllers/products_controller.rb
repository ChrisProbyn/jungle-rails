class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
    
  end

  def show
    @product = Product.find params[:id]
    @review = Review.new()
    @user = session[:user_id]
    @user_name = User.find(@user)
  end

end
