class Category < ActiveRecord::Base
	has_many :blogs
	has_many :videos

	validates :name, presence: true

	scope :get_categories, lambda {|c_type| where(:cat_type => c_type).uniq.order(:name)}

	def self.add_category(category_params)
		category = Category.new(category_params)
		category.save
	end
end