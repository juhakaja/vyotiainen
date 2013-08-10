class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
    	notice = "Your new account is now under review.
    	          We will send you email to #{@user.email} once your new account is unlocked."
      redirect_to root_path, notice: notice
    else
      render 'new'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,
                                :question, :answer)
  end
end
