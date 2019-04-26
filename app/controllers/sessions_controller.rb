class SessionsController < ApplicationController
    before_action :require_no_user, only: %i(new create)
    before_action :require_user, only: %i(destroy)
    def new
    end

    def create
        user = User.find_by_credentials(
            params[:user][:username],
            params[:user][:password]
        )
        if user
            log_in(user)
            redirect_to(users_url)
        else
            render json:user.errors.full_messages
        end
    end

    def destroy
        log_out
        redirect_back(fallback_location: users_url)
    end
end
