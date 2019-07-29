class SessionsController < ApplicationController
 
def new

end

def create
 user=User.find_by_email(params[:email])
		if user && user.authenticate(params[:password])
			session[:current_user_id] = user.id
			flash[:notice]= "You have successfully Signed In."
			cookies[:current_user_name]= user.name
			if session[:request]
				redirect_to session[:request]
			else
				redirect_to user
			end
			
			
		else
		   flash.now[:error] = 'Your email/password does not match'
		   render :new
		end

end
 def destroy
    session[:current_user_id]= nil
    redirect_to new_session_path
 end

end
