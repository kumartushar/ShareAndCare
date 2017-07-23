class AddLikesDislikesViewsToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :no_of_likes, :integer, default: 0
    add_column :videos, :no_of_dislikes, :integer, default: 0
    add_column :videos, :no_of_views, :integer, default: 0
  end
end
