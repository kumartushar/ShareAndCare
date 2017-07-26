class UserVideoHistory < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  scope :get_record_by_ids, -> (user_id, video_id) {where('user_id = ? AND video_id = ?', user_id, video_id).first}

  def self.update_view_history(user_id, video_id)
  	record = get_record_by_ids(user_id, video_id)
    record = UserVideoHistory.create(user_id: user_id, video_id: video_id) if record.blank?
  	record.increament_view_count
  	record
  end

  def self.update_like_dislike_history(user_id, video_id, status)
  	record = get_record_by_ids(user_id, video_id)
  	record.update_like_dislike_status(status)
  end

  def increament_view_count
  	self.view_count += 1
  	self.last_viewed_at = DateTime.now
  	self.save
  end

  def update_like_dislike_status(status)
  	self.like_dislike_status = status
  	self.liked_disliked_at = DateTime.now
  	self.save
  end
end
