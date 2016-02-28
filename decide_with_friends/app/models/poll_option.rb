class PollOption < ActiveRecord::Base

	belongs_to :poll
	belongs_to :option
end
