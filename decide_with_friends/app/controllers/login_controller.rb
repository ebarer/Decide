class LoginController < ApplicationController
  protect_from_forgery with: :null_session
  
  layout false

  def index

  end

  def create 
    @user = User.new(params.permit(:first_name, :last_name, :email, :fb_id))
    if @user.save
      render json: @user
    else
    render :text => "ERROR 500", :status => 500
  	end 
  end
end