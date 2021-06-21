ActiveAdmin.register User do

  permit_params :created_at, :nickname, :email, :tweet, :likes, :friends 
  filter :nickname
  filter :email
  
  index do 
    

    column :id
    column :nickname
    column :email
    
    column :tweets do |user|
      user.tweets.count
    end

    column :likes do |user|
      user.likes.count
    end

    column :friends do |user|
      user.friends.count
    end

    column :retweets do |user|
      @retweet = 0
      user.tweets.map do |tweet|
        retweet = tweet.retweet
        @retweet += retweet
      end
      @retweet
    end
    actions
  end


end
