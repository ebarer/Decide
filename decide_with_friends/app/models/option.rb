class Option < ActiveRecord::Base

	has_many :poll_options
	has_many :polls, :through => :poll_options
end
