class SessionsController < ApplicationController

  def new
    current_user ||= User.find(session[:user_id]) rescue nil if session[:user_id]
    if current_user
      redirect_to '/' and return
    end
  end

  def create
    user = User.find_by_username(params[:user][:username])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to '/' and return
    else
      redirect_to '/login', :flash => { :error => ['Incorrect credentials'] } and return
    end
  end

  def destroy
    session[:user_id] = nil
    session[:last_access_t] = nil
    redirect_to '/login'
  end

end
