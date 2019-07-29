module FriendListsHelper
	def friend?(data)   
      @friends=FriendList.where("friend_id= ? and user_id=?",data,session[:current_user_id]) 
      if @friends.first
      	 true
      else
      	 false
      end
	end

	def state?(user)
      @friends=FriendList.where("friend_id=? and user_id=?",session[:current_user_id],user)            
        	if !@friends.blank?
             @friends.each do |friend| 
               if  friend.status == 0                   
     	             return true
               else
      	          return false
	             end      
	          end
          end
  end 
end
