class SessionsController < ApplicationController

    def index
        
    end

    def new
        
    end

    def create
        if params[:provider] == 'google_oauth2'
            @user = User.from_google(auth)
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            #Find the user in the system
            @user = User.find_by(username: params[:user][:username])
            # Did we find the user & did they enter the correct password?
            if @user && @user.authenticate(params[:user][:password])
                session[:user_id] = @user.id
                redirect_to user_path(@user)
            else
                flash[:error] = "Sorry, the information you entered is incorrect. Pleas try again."
                redirect_to login_path
            end
        end
    end

    def show
        
    end

    def destroy
        session.clear
        redirect_to '/'
    end

    def omniauth
        @user = User.from_google(auth)
        session[:user_id] = @user.id
        redirect_to user_path(@user)
    end

    private

    def auth
        request.env['omniauth.auth']
    end

end