json.extract! tweet, :id, :tweet_content, :retweet, :user_id, :created_at, :updated_at
json.url tweet_url(tweet, format: :json)
