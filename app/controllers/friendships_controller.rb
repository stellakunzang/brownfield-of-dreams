class FriendshipsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def create
    @friend = User.find_by(handle: params[:future_friend])
    params[:friend_id] = @friend.id
    friendship = Friendship.create(friendship_params)
    mutual_friendship = Friendship.create(mutual_friendship_params)
    redirect_to dashboard_path if friendship.save && mutual_friendship.save
  end

  private

  def friendship_params
    params.permit(:user_id, :friend_id)
  end

  def mutual_friendship_params
    { user_id: params[:friend_id], friend_id: params[:user_id] }
  end
end
