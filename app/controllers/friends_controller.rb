class FriendsController < ApplicationController
before_action :find_user
before_action :find_follow, only: [:destroy]

  def create

    @friend = Friend.create(user_id: current_user.id, friend_id: params[:id])
    redirect_to root_path, notice: "Now you have a new friend"
    
  end

  def destroy
    @friend.destroy
    redirect_to root_path
  end

  private
  
  def find_user
    @user = User.find(current_user.id)
  end

  def find_follow
      @friend = Friend.find_by(user_id: current_user.id, friend_id: params[:id])
    end

end
