class ApplicationController < ActionController::Base
    helper_method :current_user
    
    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def log_in(user)
        session[:session_token] = user.session_token
        @current_user = user
    end

    def log_out
        current_user.reset_session_token
        @current_user = nil
        session[:session_token] = nil
    end

    def require_no_user
        return if current_user.nil?
        redirect_back(fallback_location: users_url)
    end

    def require_user
        return if !current_user.nil?
        redirect_back(fallback_location: users_url)
    end
end