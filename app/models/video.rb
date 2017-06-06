class Video < ActiveRecord::Base
	serialize :video_details, HashWithIndifferentAccess
end
