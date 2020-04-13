class ProductsController < ApplicationController

    def index
        @products = Product.all
    end

    def new
        @product = Product.new
        @product.build_category #build product a category using the nested attribbutes of category
    end

    def create
        @product = Product.new(product_params)
        @product.user_id = session[:user_id]
        if @product.save!
            redirect_to product_path(@product)
        else
            @product.build_category
            render :new
        end
    end

    def show
        @product = Product.find_by_id(params[:id])
    end

    private

    def product_params
        params.require(:product).permit(:name,:brand, :description, :category_id, category_attributes: [:name])
    end

end
