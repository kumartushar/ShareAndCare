class Video < ActiveRecord::Base
	belongs_to :channel
	serialize :video_details, Hash
end
