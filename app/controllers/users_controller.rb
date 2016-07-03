class UsersController < ApplicationController
  def new
    current_user ||= User.find(session[:user_id]) rescue nil if session[:user_id]
    if current_user
      redirect_to '/' and return
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/' and return
    else
      redirect_to '/signup', :flash => { :error => user.errors.full_messages }
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
