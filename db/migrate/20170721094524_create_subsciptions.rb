class CreateSubsciptions < ActiveRecord::Migration
  def change
    create_table :subsciptions do |t|
      t.references :user, index: true
      t.references :channel, index: true

      t.timestamps
    end
  end
end
