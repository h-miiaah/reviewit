module ReviewsHelper
    def show_header(review)
        if params[:product_id]
            content_tag(:h1, "Write a Review for #{review.product.name}", class: "text-center")
        else
            content_tag(:h1, "Write a Review", class: "text-center")
        end
    end
end
