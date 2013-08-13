class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.locked?
   	  locked_user?(user)
    elsif user && user.authenticate(params[:session][:password])
      sign_in(user)
      redirect_to user
    else
     	flash.now[:error] = 'Invalid login'
     	render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

  def locked_user?(user)
    if user.locked?
      redirect_to root_url, notice: user.under_review_note
    end
  end
end
