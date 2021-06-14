class HomeController < ApplicationController
skip_before_action :authenticate_user!
  def index
    
    @tweets = Tweet.order("created_at DESC")
    @tweets = Kaminari.paginate_array(@tweets).page(params[:page]).per(50)
    @tweet = Tweet.new
    
  end

  def retweet
    redirect_to root_path, alert: 'No es posible hacer retweet' and return if @tweet.user == current_user
    retweeted = Tweet.new(content: @tweet.tweet_content)
    retweeted.user = current_user

    if retweeted.save
      if @tweet.retweet.nil?
        @tweet.update(retweet: @tweet.retweet = 1)
      else
        @tweet.update(retweet: @tweet.retweet += 1)
      end
        redirect_to root_path, notice: 'Retweet was posted successfully.'
      else
        redirect_to root_path, alert: "Unable to retweet."
    end
  end


end
