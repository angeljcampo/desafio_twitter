class HomeController < ApplicationController
skip_before_action :authenticate_user!
def index
  @tweets = Tweet.order("created_at DESC")
  @tweets = Kaminari.paginate_array(@tweets).page(params[:page]).per(4)
  @tweet = Tweet.new
end

end
