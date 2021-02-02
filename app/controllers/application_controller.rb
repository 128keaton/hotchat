class ApplicationController < ActionController::Base
  before_action :set_session

  private

  def set_session
    invalid_session = false

    if not session[:chat_session].nil?
      begin
        chat_session = ChatSession.find(session[:chat_session])
      rescue
        invalid_session = true
      end

      if chat_session.nil? or chat_session.user_id.nil?
        invalid_session = true
      else
        @session = chat_session
        @user = User.find(chat_session.user_id)
      end
    else
      invalid_session = true
    end

    if invalid_session
      go_to_login
    end
  end

  def go_to_login
    redirect_to login_path
  end
end
