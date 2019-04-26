class UsersController < ApplicationController
    before_action :require_no_user, only: %i(new create)

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            log_in(@user)
            render :index
        else
            render json:@user.errors.full_messages
        end
    end

    def index
        @users = User.all
    end

    private
    def user_params
        params.require(:user).permit(:username, :password, :email)
    end


end
