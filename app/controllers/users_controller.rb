class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, except: [:new, :create]
  before_action :correct_user, except: [:new, :create]
  before_action :locked_user, except: [:new, :create]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if params[:captcha].to_i != 4
    	flash.now[:error] = 'Your math is not very strong...'
    	render 'new'
    elsif @user.save
      redirect_to root_path, notice: @user.under_review_note
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

  def user_captcha
    params.require(:user).permit(:captcha)
  end

  def signed_in_user
    redirect_to login_url, notice: "Please login." unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user)
  end

  def locked_user
    @user = User.find(params[:id]) 
    if @user.locked?
      redirect_to root_url, notice: @user.under_review_note
    end
  end
end
