class FriendshipsController < ApplicationController
  def create
    @friend = User.find_by(handle: params[:future_friend])
    params[:friend_id] = @friend.id
    friendship = Friendship.create(friendship_params)
    redirect_to dashboard_path if friendship.save
  end

  private

  def friendship_params
    params.permit(:user_id, :friend_id)
  end
end
