class AddVideoDetailsToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :video_details, :text
    remove_column :videos, :url, :string
  end
end
