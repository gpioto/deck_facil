class CommentsController < ApplicationController
  def create
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment].permit(:comment))
    @comment.user = @current_user

    if @comment.save
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end
end
