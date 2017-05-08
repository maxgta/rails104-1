class PostsController < ApplicationController
  before_action :find_post_and_check_permission , :only => [:edit, :update, :destroy]
  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def destroy
    @post.destroy
    redirect_to groups_path, alert: "Post delete"
  end

  def edit
    @group = Group.find(params[:group_id])
    end

  def update
    @group = Group.find(params[:group_id])
  if @post.update(post_params)
    redirect_to account_posts_path, notice: "Update Success"
  else
    render :edit
  end
end


  private

  def post_params
    params.require(:post).permit(:content)
  end
end

def find_post_and_check_permission
    @post = Post.find(params[:id])
  if current_user != @post.user
    redirect_to root_path, alert: "You have no permission"
  end
end
