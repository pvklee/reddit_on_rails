class PostsController < ApplicationController
    before_action :require_user, only: %i(new create edit update)

    def new
        @sub = Sub.find(params[:sub_id])
        @post = Post.new
    end

    def create
        @post = current_user.authored_posts.new(post_params)
        @post.primary_sub_id = params[:sub_id]
        if @post.save
            @sub ||= @post.primary_sub
            redirect_to(sub_post_url(@sub, @post))  
        else
            redirect_to(subs_url)
        end
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])
        @post.update_attributes(post_params)
        if @post.save
            @sub ||= @post.primary_sub
            redirect_to(sub_post_url(@sub, @post))    
        else
            redirect_to(subs_url)
        end
    end

    def show
        @sub = Sub.find(params[:sub_id])
        @post = Post.find(params[:id])
    end

    def index
        @posts = Post.all
    end

    private
    def post_params
        params.require(:post).permit(:title, :url, :content)
    end
end
