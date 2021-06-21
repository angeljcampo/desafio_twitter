class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if user_signed_in?
      @tweets = Tweet.tweets_for_me(current_user).order("created_at DESC")
      if params[:q]
        @tweets = Tweet.finder(params[:q]).order("created_at DESC") 
      end
    else
      @tweets = Tweet.order("created_at DESC")
      if params[:q]
        @tweets = Tweet.finder(params[:q]).order("created_at DESC")
      end
    end
    @tweet = Tweet.new
    @friends = Friend.all
    @tweets = Kaminari.paginate_array(@tweets).page(params[:page]).per(50)
    @users = User.all
  end


end
