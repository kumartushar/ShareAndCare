class ChangetypeTocatType < ActiveRecord::Migration
  def change
  	rename_column :categories, :type, :cat_type
  end
end
