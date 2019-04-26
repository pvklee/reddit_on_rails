class CommentsController < ApplicationController
    def create
        @comment = current_user.authored_comments.new(comment_params)
        @comment.post_id = params[:post_id]
        @post = Post.find(params[:post_id])
        if @comment.save
            redirect_back(fallback_location: post_url(@post))
        else
            render json:@comment.errors.full_messages
        end
    end

    def upvote
        cast_vote(1)
    end

    def downvote
        cast_vote(-1)
    end

    private
    def comment_params
        params.require(:comment).permit(:content, :parent_comment_id)
    end

    def cast_vote(direction)
        @comment = Comment.find(params[:id])
        @vote = @comment.votes.find_or_initialize_by(user: current_user)
        unless @vote.update(value: direction)
          flash[:errors] = @vote.errors.full_messages
        end
        redirect_to post_url(@comment.post)
    end
end
