class Video < ActiveRecord::Base
	belongs_to :channel
	serialize :video_details, Hash

	def self.get_by_access_code(access_code)
		Video.where(access_code: access_code).first
	end
end
