class ProductsController < ApplicationController

    before_action :set_product, only: [:show, :edit, :update, :delete]
    before_action :require_login
    
    def index
        @products = Product.order_by_rating
    end

    def new
        @product = Product.new
        @product.build_category #build product a category using the nested attribbutes of category
    end

    def create
        @product = Product.new(product_params)
        @product.user_id = session[:user_id] #or = current_user.id
        if @product.save#!
            redirect_to product_path(@product)
        else
            @product.build_category
            render :new
        end
    end

    def show
        
    end

    def edit
        if @product.user_id != current_user.id
            redirect_to products_path           
        end
    end

    def update
        if @product.user_id != current_user.id
            redirect_to products_path           
        end
        if @product.update(product_params)
            redirect_to product_path(@product)
        else
            render :edit
        end
    end

    def destroy
        # byebug
        @product.destroy
        redirect_to products_path
    end

    private

    def product_params
        params.require(:product).permit(:name,:brand, :description, :category_id, category_attributes: [:name])
    end

    def set_product
        @product = Product.find_by_id(params[:id])
    end

end
