class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :category
      t.string :sub_category
      t.text :description
      t.string :published_status
      t.date :published_on

      t.timestamps
    end
  end
end
