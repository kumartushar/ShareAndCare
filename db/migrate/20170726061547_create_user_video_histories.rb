class CreateUserVideoHistories < ActiveRecord::Migration
  def change
    create_table :user_video_histories do |t|
      t.references :user, index: true
      t.references :video, index: true
      t.string :like_dislike_status, default: "neutral"
      t.datetime :liked_disliked_at
      t.integer :view_count, default: 0
      t.datetime :last_viewed_at
      t.integer :view_progress, default: 0

      t.timestamps
    end
  end
end
