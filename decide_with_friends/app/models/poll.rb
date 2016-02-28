class Poll < ActiveRecord::Base

	has_many :user_polls
	has_many :users, :through => :user_polls, :source => :user, :class_name => "User"
	
	has_many :poll_options
	has_many :options, :through => :poll_options

end
