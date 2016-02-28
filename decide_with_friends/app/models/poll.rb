class Poll < ActiveRecord::Base

	has_many :poll_options
	has_many :options, :through => :poll_options
end
