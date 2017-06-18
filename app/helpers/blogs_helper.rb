module BlogsHelper
	def blog_category_list
		list = Category.get_categories('blog_category').collect{|ele| [ele.name, ele.id]}
		list.unshift(['--Select--', ''])
	end
end
