class LoginController < ApplicationController
  protect_from_forgery with: :null_session
  
  layout false

  def index

  end

  def create 
    if !User.exists?(fb_id: params[:fb_id])
      @user = User.new(params.permit(:first_name, :last_name, :email, :fb_id))
      if @user.save
        render json: @user
      else
      render :text => "ERROR 500", :status => 500
    	end
    else
      render :json => '{"Error" : "User already exists"}'
    end
  end
end