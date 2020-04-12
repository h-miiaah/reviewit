class SessionsController < ApplicationController
    
    def index
        
    end

    def new
        
    end

    def create
        #Find the user in the system
        @user = User.find_by(username: params[:user][:username])
        # Did we  find the user & did they enter the correct password?
        if @user && @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            flash[:error] = "Sorry, the information you entered is incorrect. Pleas try again."
            redirect_to login_path
        end
    end

    def destroy
        session.clear
        redirect_to '/'
    end

end