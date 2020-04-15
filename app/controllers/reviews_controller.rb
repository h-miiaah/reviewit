class ReviewsController < ApplicationController

    before_action :require_login

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
        if @review.save#!
            redirect_to review_path(@review)
        else
            render :new
        end
    end

    def show
        @review = Review.find_by_id(params[:id])

    end

    def edit
        @review = Review.find_by_id(params[:id])
        if @review.user_id != current_user.id
            redirect_to reviews_path           
        end
    end

    def update
        @review = Review.find_by_id(params[:id])
        if @review.user_id != current_user.id
            redirect_to reviews_path           
        end
        if @review.update(review_params)
            redirect_to review_path(@review)
        else
            render :edit
        end
    end

    def destroy
        @review = Review.find_by_id(params[:id])
        @review.destroy
        redirect_to reviews_path
    end

    private

    def review_params
        params.require(:review).permit(:stars, :title, :content, :product_id)
    end
end
