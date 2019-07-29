class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_signin , only: [:show, :edit, :update, :destroy]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    
    @user_id=FriendList.where("user_id = ? and status = ?", @user.id, 1)
  
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
def accept
  @user=User.find_by_id(session[:current_user_id])
         @friend=FriendList.where("friend_id= ? and user_id=?",session[:current_user_id],params[:user_id]) 
   @friend.each do |row|
    row.status = 1
    row.save
   end

  friend=FriendList.new(user_id:session[:current_user_id],friend_id:params[:user_id],status:1)
  friend.save
  redirect_to user_path(session[:current_user_id])
end  
def reject
  @user=User.find_by_id(session[:current_user_id])
    @friend=FriendList.where("friend_id= ? and user_id=?",session[:current_user_id],params[:user_id]) 
   @friend.each do |row|
    row.status = 2
    row.save
   end
   redirect_to user_path(session[:current_user_id])
end
def friends
@friend_name=[]
@friends=FriendList.where("user_id=? and status=?",session[:current_user_id],1) 
@friends.each do |f_id|
@friend_name << User.find_by_id(f_id.friend_id)
end

if @friend_name.empty?
  flash[:notice]="Haven't found any friend"
   redirect_to user_path(session[:current_user_id])
 
end

end
def requests
@friend_requests=[]
@friends=FriendList.where("friend_id=? and status=? ",session[:current_user_id],0) 
@friends.each do |f_id|
@friend_requests << User.find_by_id(f_id.user_id)
end
if @friend_requests.empty?
  flash[:notice]="Haven't found any new friend request"
   redirect_to user_path(session[:current_user_id])
 
end
end

def pending_requests
@pending_requests=[]
@friends=FriendList.where("user_id=? and status=? ",session[:current_user_id],0) 
@friends.each do |f_id|
@pending_requests << User.find_by_id(f_id.friend_id)

end
if @pending_requests.empty?
  flash[:notice]="Haven't found any pending request"
   redirect_to user_path(session[:current_user_id])
end
end
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email,:password, :password_confirmation)
    end

end
