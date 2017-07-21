class Channel < ActiveRecord::Base
  belongs_to :user #author of channel
  has_many :subsciptions
  has_many :subscribed_users, through: :subsciptions, source: :user
  has_many :videos
end
