class User < ActiveRecord::Base
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
