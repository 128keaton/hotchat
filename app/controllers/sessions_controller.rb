class SessionsController < ApplicationController
  before_action :set_user, only: %i[ logout index ]

  def new
    @user = User.new
  end

  def login
    puts params
    @user = User.find_by(user_params)

    unless @user
      @user = User.new(user_params)
      @user.save
    end

    session[:current_user_id] = @user.id
    redirect_to rooms_path
  end

  def logout
    User.find(session[:current_user_id]).delete

    session.delete(:current_user_id)
    redirect_to rooms_path
  end

  private
  def set_user
    current_user_id = session[:current_user_id]

    begin
      @user = User.find(current_user_id)
    rescue ActiveRecord::RecordNotFound => e
      redirect_to login_path
    end
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
