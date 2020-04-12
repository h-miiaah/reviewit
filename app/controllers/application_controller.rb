class ApplicationController < ActionController::Base

    helper_method :current_user, :logged_in?

    private

    def current_user
        @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end

    def logged_in?
        #When theres a session user_id user is logged in
        !!session[:user_id]
    end

    def redirect_if_not_logged_in
        #Redirects to login path if user is not logged in
        redirect_to login_path if !logged_in?
    end

end
