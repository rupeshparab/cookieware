class SessionsController < ApplicationController

  def create
    if session.key?("user_id") && !User.find_by_id(session[:user_id]).blank?
      redirect_to '/' and return
    end
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/' and return
    else
      redirect_to '/login', :flash => { :error => ['Incorrect credentials'] } and return
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
