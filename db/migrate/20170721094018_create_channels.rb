class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :name
      t.references :user, index: true

      t.timestamps
    end
  end
end
