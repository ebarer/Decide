class OptionController < ApplicationController
  protect_from_forgery with: :null_session
  
  layout false
  
  def index
    @options = Option.all
  end
  
  def new
    @option  = Option.new
  end
  
  def edit
    @option = Option.find(params[:id])
  end
  
  def create
    @option = Option.new(option_params)
    
    if @option.save
      redirect_to :action => index
    else
      render 'new'
    end
  end
    
  def destroy
    @option.destroy
  end

  private
    def option_params
      params.require(:title)
    end
    
end
