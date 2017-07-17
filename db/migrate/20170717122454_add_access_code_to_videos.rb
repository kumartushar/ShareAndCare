class AddAccessCodeToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :access_code, :string
  end
end
