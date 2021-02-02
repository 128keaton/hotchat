class AuthController < ApplicationController
  skip_before_action :set_session, only: %i[ new login ]

  def new
    @user = User.new
  end

  def login
    name = "#{user_params[:name]}##{rand.to_s[2..6]}"

    user = User.new(user_params.merge(name: name))
    user.save

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
