class LoginController < ApplicationController
  protect_from_forgery with: :null_session
  
  layout false

  def index
      if User.exists?(id: params[:pk_uid])
        @user = User.find(params[:pk_uid])
        options ||= []
        @user.polls.each do |poll|
            @option = @poll.options
            options << @option
        end

        render :json => {:id => @user.id, :first_name => @user.first_name, :last_name => @user.last_name, :email => @user.email, :fb_id => @user.fb_id, :profile_picture => @user.profile_picture,
          :polls => @user.polls, :options => options}
      else
        render :json => '{"status" : "-1", "Error_msg" : "User does not exist"}'
      end
  end

  def create 
    if !User.exists?(fb_id: params[:fb_id])
      @user = User.new(params.permit(:first_name, :last_name, :email, :fb_id, :profile_picture))
      @user.save
      render :json => {:id => @user.id,:first_name => @user.first_name, :last_name => @user.last_name, :email => @user.email, :fb_id => @user.fb_id, :profile_picture => @user.profile_picture,
          :polls => @user.polls}
    else
      @user = User.where(params[:fb_id])
      render :json => {:id => @user.id,:first_name => @user.first_name, :last_name => @user.last_name, :email => @user.email, :fb_id => @user.fb_id, :profile_picture => @user.profile_picture,
          :polls => @user.polls}
    end
  end
end