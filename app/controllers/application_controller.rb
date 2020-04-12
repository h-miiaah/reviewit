class ApplicationController < ActionController::Base

    helper_method :current_user, :logged_in?, :require_login

    private

    def current_user
        #set an instance variable for the current user
        @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end

    def logged_in?
        #looks to see if the user is logged in
        !!session[:user_id]
    end

    def require_login
        #redirects to login path if user is not logged in
        unless logged_in?
            flash[:error] = "You must be logged in to access this."
            redirect_to login_path
        end
    end

end
