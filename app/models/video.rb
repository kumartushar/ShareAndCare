class Video < ActiveRecord::Base
	serialize :video_details, Hash
end
