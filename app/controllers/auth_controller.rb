class AuthController < ApplicationController
  skip_before_action :set_session, only: %i[ new login ]

  def new
    @user = User.new
  end

  def login
    user = User.find_by(user_params)

    unless user
      user = User.new(user_params)
      user.save
    end

    chat_session = ChatSession.find_by(user_id: user.id)

    unless chat_session
      chat_session = ChatSession.new(user_id: user.id)
      chat_session.save
    end

    session[:chat_session] = chat_session.id

    redirect_to root_path
  end

  def logout
    chat_session = ChatSession.find(session[:chat_session])

    User.find(chat_session.user_id).destroy
    chat_session.destroy

    session.delete(:chat_session)
    redirect_to login_path
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

end
