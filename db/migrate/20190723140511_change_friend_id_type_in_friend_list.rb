class ChangeFriendIdTypeInFriendList < ActiveRecord::Migration[5.2]
  def change
  	change_column :friend_lists, :friend_id, :integer
  end
end
