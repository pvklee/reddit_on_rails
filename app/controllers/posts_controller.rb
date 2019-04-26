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
            render json: @post.errors.full_messages
            # redirect_to(subs_url)
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
        @post = Post.find(params[:id])
    end

    def index
        @posts = Post.all
    end

    def upvote
        cast_vote(1)
    end

    def downvote
        cast_vote(-1)
    end
    
    private
    def post_params
        params.require(:post).permit(:title, :url, :content, cross_posted_sub_ids: [])
    end

    def cast_vote(direction)
        @post = Post.find(params[:id])
        @vote = @post.votes.find_or_initialize_by(user: current_user)
    
        unless @vote.update(value: direction)
          flash[:errors] = @vote.errors.full_messages
        end
    
        redirect_back(fallback_location: post_url(@post))
    end
end
