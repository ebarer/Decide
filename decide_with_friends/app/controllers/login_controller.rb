class LoginController < ApplicationController
  
  layout false

  def index

  end

  def create 
    # Instantiate a new object using form parameters
    @user = User.new(user_params)
    # Save the object
    if @user.save
    # If save succeeds, redirect to the index action
      redirect_to(:action => 'index')
    else
    # If save fails, redisplay the form so user can fix problems
      redirect_to(:action => 'index')
  	end 
  end
end
