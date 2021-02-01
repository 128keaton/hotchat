class SessionsController < ApplicationController
  def new
  end

  def login
    @user = User.find_by(name: params[:username])

    unless @user
      @user = User.new(name: params[:username])
      @user.save
    end

    session[:current_user_id] = @user.id
    redirect_to rooms_path
  end
end
