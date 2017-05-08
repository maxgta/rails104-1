class Account::GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = current_user.participated_groups
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(groups_path)
    if group.save
      redirect_to groups_path
    else
      render :new
    end
  end
end
