class LoginController < ApplicationController
  protect_from_forgery with: :null_session
  
  layout false

  def index

  end

  def create 
    @user = User.new(params.permit(:first_name, :last_name, :email, :fb_id))
    @user.save
    #if @user.save
    # If save succeeds, redirect to the index action
      #redirect_to(:action => 'index')
    #else
    # If save fails, redisplay the form so user can fix problems
      #redirect_to(:action => 'index')
  	#end 
  end
end