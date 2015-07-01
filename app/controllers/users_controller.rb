class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      #success
      flash[:success] = "Welcome to Roommate.in !"
      redirect_to @user
    else
      render 'new'
    end
  end
end
