class ApplicationController < ActionController::Base
private 
	  def require_signin
        unless current_user
        	 flash[:error]="You need to signin"
           redirect_to new_session_path
        end 
    end

    def current_user
       @current_user ||= User.find_by_id(session[:current_user_id]) if session[:current_user_id]
	  end
helper_method :require_signin
end
