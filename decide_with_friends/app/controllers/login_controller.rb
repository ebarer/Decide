class LoginController < ApplicationController
  protect_from_forgery with: :null_session
  
  layout false

  def index
      if User.exists?(id: params[:pk_uid])
        @user = User.find(params[:pk_uid])
        render :json => {:first_name => @user.first_name, :last_name => @user.last_name, :email => @user.email, :profile_picture => @user.profile_picture,
          :polls => @user.polls}
      else
        render :json => '{"Error" : "-1", "Error_msg" : "User does not exist"}'
      end
  end

  def create 
    if !User.exists?(fb_id: params[:fb_id])
      @user = User.new(params.permit(:first_name, :last_name, :email, :fb_id, :profile_picture))
      if @user.save
        render json: @user.id
      else
        render :json => '{"Error" : "53", "Error_msg" : "Error saving to database"}'
    	end
    else
      render :json => '{"Error" : "69", "Error_msg" : "User already exists"}'
    end
  end
end