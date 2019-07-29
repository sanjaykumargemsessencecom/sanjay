class FriendListsController < ApplicationController
def create
	if session[:current_user_id]
	@user=User.find_by_id(session[:current_user_id])
    @friend=User.find(params[:user_id])
    @friend_id=@friend.id.to_i
    @friend=@user.friend_lists.create(friend_id: @friend_id)
    redirect_to users_path
else
	flash[:notice]="You Need to SignIn..."
	redirect_to new_session_path
end
    
end
def destroy
    @friend=FriendList.find_by_friend_id(params[:user_id])
    status=@friend.destroy
    redirect_to users_path
end



end
