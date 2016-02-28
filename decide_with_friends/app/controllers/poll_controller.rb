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
    @poll = Poll.new(params.permit(:title, :isEnded))

    if @poll.save
      if (params[:options])
        params[:options].each do |option|
          @Poll.options << Option.create(:title => option.title)
        end
      end
      render :json @poll.id
    else
      render :json => '{"Error" : "53", "Error_msg" : "Error saving to database"}'
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
