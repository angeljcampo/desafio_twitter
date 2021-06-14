class AddIdRefToTweet < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :original_id, :integer
  end
end
