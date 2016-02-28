class LoginController < ApplicationController
  protect_from_forgery with: :null_session
  
  layout false

  def index
      if User.exists?(id: params[:pk_uid])
        @user = User.find(params[:pk_uid])
        render :json => {:first_name => @user.first_name, :last_name => @user.last_name, :email => @user.email, :fb_id => @user.fb_id, :profile_picture => @user.profile_picture,
          :polls => @user.polls}
      else
        render :json => '{"Error" : "-1", "Error_msg" : "User does not exist"}'
      end
  end

  def create 
    if !User.exists?(fb_id: params[:fb_id])
      @user = User.new(params.permit(:first_name, :last_name, :email, :fb_id, :profile_picture))
      @user.save
      render json: @user
    end
  end
end