class UsersController < ApplicationController
  before_action :setter, only: [:show]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.authenticate(params[:user][:password_confirmation])
      @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      redirect_to new_user_path
    end
  end

  def show

  end

  private

  def user_params
    params.require(:user).permit(:name, :password)
  end

  def setter
    @user = User.find_by(id: session[:user_id])
  end
end
