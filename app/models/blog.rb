class Blog < ActiveRecord::Base
	has_many :comments, as: :commentable
	mount_uploader :avatar, ImageUploader
	validates :title, presence: true
	validate :avatar_size


	def short_name
		"#{self.title[0]}"
	end
	
	private
	def avatar_size
		errors.add(:avatar, "Should be less than 3MB") if avatar.size > 3.megabytes
	end
end
