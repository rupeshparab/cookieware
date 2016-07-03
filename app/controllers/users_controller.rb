class UsersController < ApplicationController
  def new
    if session.key?("user_id") && !User.find_by_id(session[:user_id]).blank?
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
