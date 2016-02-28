class PollOption < ActiveRecord::Base

	belongs_to :Poll
	belongs_to :Option
end
