class SessionsController < ApplicationController
  before_action :require_logged_in, only:[:destroy]


  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )
    if user.nil?
      flash[:error] = ["Invalid username/password"]
      render :new
    else
      login!(user)
      redirect_to cats_url
    end
  end

  def destroy
    current_user.reset_session_token! unless current_user
    current_user.session_token = nil
    # logout!
    # redirect_to new_session_url
  end
end
