class AddDescriptionCategoryTagsToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :description, :text
    add_column :videos, :category, :string
    add_column :videos, :tags, :string
  end
end
