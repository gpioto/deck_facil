class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.order("created_at DESC")
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @post = @current_user.posts.build
  end

  def create
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @post = @current_user.posts.build(post_params)

    if @post.save
      flash[:success] = "Saved"
      redirect_to @post
    else
      flash[:error] = "There was a problem adding"
      render action: :new
    end
  end


  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy!
    redirect_to '/posts/', :notice => "Your post has been deleted"
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end

end
