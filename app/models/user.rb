class User < ActiveRecord::Base
	has_one :channel #channel created by user. This creates an association of name 'channel', refering to class 'Channel'(db table - channels), and Foreign key as user_id from channels table. We can specify class and foreign key explicitely while declaring association
	has_many :subsciptions
	has_many :subscribed_channels, through: :subsciptions, source: :channel
	has_many :owned_videos, through: :channel, source: :videos
	has_many :subscribed_videos, through: :subscribed_channels, source: :videos
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable,
	     :confirmable, :timeoutable

	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	validates :first_name, :last_name, :password, :presence => true
	validates :first_name, :last_name, length: {maximum: 20}
	validates :password, :password_confirmation, length: {in: 6..20}
	validates :gender, numericality: {only_integer: true}
end
