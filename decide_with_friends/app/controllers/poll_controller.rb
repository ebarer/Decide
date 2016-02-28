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

      options = ActiveSupport::JSON.decode(params[:options])

      if (options)
        options.each do |option|
          @poll.options << Option.create(:title => option["title"])
        end
        render json: @poll
      end
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
