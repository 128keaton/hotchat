module MessagesHelper
  def message_class(message, user)
    if not user.nil? and message.user_id === user.id
      return 'self-message'
    end

    puts session.inspect
    'other-message'
  end
end
