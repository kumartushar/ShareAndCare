class Video < ActiveRecord::Base
	belongs_to :channel
	has_many :user_video_histories
	has_many :users, through: :user_video_histories
	serialize :video_details, Hash

	def self.get_by_access_code(access_code)
		Video.where(access_code: access_code).first
	end

	def increament_no_of_views
		self.no_of_views += 1
		self.save
	end

	def update_no_of_likes_dislikes(action)
		self.no_of_likes += 1 if action == "0" || action == "4"
		self.no_of_dislikes += 1 if action == "1" || action == "3"
		self.no_of_likes -= 1 if action == "2" || action == "3"
		self.no_of_dislikes -= 1 if action == "4" || action == "5"
		self.save
	end
end
