module Api
  module V1
    class NewsController < V1Controller
      include ActionController::HttpAuthentication::Basic::ControllerMethods
      http_basic_authenticate_with name: "hola", password: "hola", only: :create
      
      def news
        all_tweets = Tweet.order("created_at DESC")
        counter = 0
        tweets = []

        all_tweets.each do |tweet|
          if counter < 50
            tweets.push({
              id: tweet.id,
              content:tweet.tweet_content,
              user_id:tweet.user_id,
              like_count:tweet.likes.count,
              retweets_count:tweet.retweet,
              retwitted_from:tweet.original_id 
            })
            counter += 1
          end
        end

        render json: tweets
      end

      def ranged
        x = []
        fecha1 = params[:fecha1]
        fecha2 = params[:fecha2]
        all_tweets = Tweet.order("created_at DESC")
        
        all_tweets.each do |tweet|
          if tweet.created_at.strftime("%Y-%m-%d") >= fecha1 && tweet.created_at.strftime("%Y-%m-%d") <= fecha2
            x.push({
              id: tweet.id,
              created_at: tweet.created_at,
              content:tweet.tweet_content,
              user_id:tweet.user_id,
              like_count:tweet.likes.count,
              retweets_count:tweet.retweet,
              retwitted_from:tweet.original_id 
            })
          end
        end
        render json: x
      end

      def create
        body = request.raw_post
        body1 = JSON.parse(body)
        new_tweet = Tweet.new(body1)
        user = User.find(new_tweet[:user_id]) rescue nil
        
        if user.nil?
          render json: {error: "User doesn't exist"}
        else
          new_tweet.save
            render json: new_tweet
        end   
      end

    end
  end
end