class User < ActiveRecord::Base

	has_many :user_polls
	has_many :polls, :through => :user_polls, :source => :user
end
