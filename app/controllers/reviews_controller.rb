class ReviewsController < ApplicationController
    before_filter :find_review, :only => [:destroy]
    before_filter :create_review, :only => [:create]
    before_filter :set_user, :except => [:login, :sign_up]

    def create
        if @review.save
            redirect_to "/products/#{params[:product_id]}"
          else
            flash.now[:alert] = 'Error while sending review!'
            redirect_to "/products/#{params[:product_id]}"
          end
        
      end
    def destroy
        @review.destroy
        redirect_to "/products/#{params[:product_id]}"
        
    end
    protected 
    def find_review
        @review =  Review.find(params[:id])
    end

    def create_review
        @review =  Review.new(product_id: params[:product_id], rating: params[:review][:rating], description: params[:review][:description], user_id: session[:user_id])
    end
    def set_user 
        @user = User.find_by_email(params[:email])
    end


end
