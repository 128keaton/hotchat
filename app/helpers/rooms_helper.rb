module RoomsHelper

  def is_owner(room, user)

    puts "IS OWNER #{room.inspect}"

    puts "USER #{@user.inspect}"
    if room.nil? || user.nil?
      return false
    end

    room.owner_id == user.id
  end
end
