class AddStatusToFriendLists < ActiveRecord::Migration[5.2]
  def change
  	add_column :friend_lists,:status,:integer,:default => 0
  end
end
