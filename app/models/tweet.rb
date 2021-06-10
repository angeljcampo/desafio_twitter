class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  validates :tweet_content, presence: true
  
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
