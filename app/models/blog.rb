class Blog < ActiveRecord::Base
	mount_uploader :avatar, ImageUploader
	validates :title, presence: true
	validate :avatar_size


	private
	def avatar_size
		errors.add(:avatar, "Should be less than 3MB") if avatar.size > 3.megabytes
	end
end
