class ReviewsController < ApplicationController

    def index
        if @product = Product.find_by_id(params[:id])
            @reviews = @product.reviews #if it's nested
        else
            @reviews = Review.all #if it's not nested
        end
    end

    def new
        if @product = Product.find_by_id(params[:product_id])
            @review = @product.reviews.build
        else
            @review = Review.new
        end
    end

    def create
        @review = current_user.reviews.build(review_params)
        if @review.save!
            redirect_to review_path(@review)
        else
            render :new
        end
    end

    def show
        @review = Review.find_by_id(params[:id])

    end

    private

    def review_params
        params.require(:review).permit(:stars, :title, :content, :product_id)
    end
end
