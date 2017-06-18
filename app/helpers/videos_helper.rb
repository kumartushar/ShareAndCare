module VideosHelper
	def video_category_list
		list = Category.get_categories('video_category').collect{|ele| [ele.name, ele.id]}
		list.unshift(['--Select--', ''])
	end
end
