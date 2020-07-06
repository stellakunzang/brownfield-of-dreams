class Follower
  attr_reader :handle,
              :url

  def initialize(follower_data)
    @handle = follower_data[:login]
    @url = follower_data[:html_url]
  end

  def in_system?
    @friend = User.find_by(handle: @handle)
    @friend.present?
  end

  def already_friends?(user_id)
    friendship = Friendship.find_by(friend_id: @friend.id, user_id: user_id)
    friendship.present?
  end

end
