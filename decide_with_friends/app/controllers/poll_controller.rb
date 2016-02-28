class PollController < ApplicationController
  protect_from_forgery with: :null_session
  
  layout false
  
  def index
    @polls = Poll.all
  end
  
  def new
    @poll  = Poll.new
  end
  
  def edit
    @poll = Poll.find(params[:id])
  end
  
  def create
    @poll = Poll.new(poll_params)
    
    if (params[:option_ids])
      params[:options].each do |option|
        @Poll.options << Option.create(option)
      end

    if @poll.save
      redirect_to :action => index
    else
      render 'new'
    end
  end
    
  def destroy
    @poll.destroy
  end

  private
    def poll_params
      params.require(:title).permit(:options)
    end
    
end
