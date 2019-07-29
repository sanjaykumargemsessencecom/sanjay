module ApplicationHelper
def notify
@friend_requests=[]
@friends=FriendList.where("friend_id=? and status=? ",session[:current_user_id],0) 
@friends.each do |f_id|
@friend_requests << User.find_by_id(f_id.user_id)
end
if @friend_requests.empty?
  flash[:notice]="Haven't found any new friend request"
     @changing_text=""
 else
 @changing_text="changing_text"
end
end


end
