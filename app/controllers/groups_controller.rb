class GroupsController < ApplicationController
  before_action :authenticate_user!,only: [:new, :create, :edit, :update, :destroy]
  before_action :find_group_and_check_permission, only: [:edit, :update, :destroy]
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts.recent.paginate(:page => params[:page], :per_page => 5)
    
  end

  def edit
  end
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user

    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path, notice: "修改成功"
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path,flash[:alert] = "群組己刪除"
  end

  private

  def find_group_and_check_permission
      @group = Group.find(params[:id])

      if current_user != @group.user
        redirect_to root_path, alert: "不好意思，你沒有權限操作！"
      end
    end

  def group_params
    params.require(:group).permit(:title, :description)
  end
end
