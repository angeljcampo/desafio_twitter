class Like < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  def liked
    @tweet.likes.find {|like| like.user.id == current_user.id}
  end
  
end
