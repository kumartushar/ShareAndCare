class Category < ActiveRecord::Base
	has_many: blogs
	has_many: videos
end
