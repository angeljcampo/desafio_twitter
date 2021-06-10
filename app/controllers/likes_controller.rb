class LikesController < ApplicationController
# before_action :require_login
before_action :find_tweet
before_action :find_like, only: [:destroy]

  def create
    @likes = Like.create(tweet_id: @tweet, user_id: current_user.id)
    redirect_to root_path(@tweet)
  end
  def destroy
    if !(already_liked?)
      flash[:notice] = "Tweet already unliked"
    end
  end
  
  private

  def find_tweet
    @tweet = Tweet.find_by(id: params[:id])
  end
  
  def find_like
    @like = @tweet.likes.find(params[:id])
  end
  
  def already_liked?
    Like.where(user_id: current_user.id, tweet_id: params[:tweet_id].present?)
  end

end
