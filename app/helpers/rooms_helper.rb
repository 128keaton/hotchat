module RoomsHelper
  def member_class(user, local_user)
    if not user.nil? and not local_user.nil? and not local_user.id.nil? and local_user.id === user.id
      return 'self-member'
    end

    'other-member'
  end

  def is_owner(room, user)
    if room.nil? || user.nil?
      return false

    end

    room.owner_id == user.id
  end
end
