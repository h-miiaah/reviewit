module ApplicationHelper

    def render_nav_bar_links
        if logged_in?
            render partial: '/layouts/logged_in_nav_links'
        else
            render partial: '/layouts/logged_out_nav_links'
        end
    end

end
