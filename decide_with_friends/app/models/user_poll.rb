class UserPoll < ActiveRecord::Base

	belongs_to :User
	belongs_to :Poll
end
