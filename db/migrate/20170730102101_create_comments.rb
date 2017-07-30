class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true
      t.integer :commentable_id, index: true
      t.string :commentable_type
      t.text :body

      t.timestamps
    end
  end
end
