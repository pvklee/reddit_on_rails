class SubsController < ApplicationController
    before_action :require_user, only: %i(new create edit update)

    def new
        @sub = Sub.new
    end

    def create
        @sub = current_user.created_subs.new(sub_params)
        if @sub.save
            render :show
        else
            redirect_to(subs_url)
        end
    end

    def edit
        @sub = Sub.find(params[:id])
    end

    def update
        @sub = Sub.find(params[:id])
        @sub.update_attributes(sub_params)
        if @sub.save
            render :show    
        else
            redirect_to(subs_url)
        end
    end

    def show
        @sub = Sub.find(params[:id])
    end

    def index
        @subs = Sub.all
    end

    private
    def sub_params
        params.require(:sub).permit(:title, :description)
    end
end
