class ReviewsController < ApplicationController
    
    def create
        raise "Yay, I'm here!"
        @product = Product.find params[:id]
        redirect_to order
      end
end
