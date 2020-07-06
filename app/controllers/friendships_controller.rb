class FriendshipsController < ApplicationController
  def create
    @friend = User.find_by(handle: params[:follower])
    params[:friend_id] = @friend.id
    friendship = Friendship.create(friendship_params)
    if friendship.save
      redirect_to dashboard_path
    end 
  end

  private

  def friendship_params
    params.permit(:user_id, :friend_id)
  end
end
