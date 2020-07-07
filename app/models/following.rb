class Following
  attr_reader :handle,
              :url

  def initialize(following_data)
    @handle = following_data[:login]
    @url = following_data[:html_url]
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
