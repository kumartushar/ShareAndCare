ThinkingSphinx::Index.define :blog, :with => :active_record do
	indexes title, :sortable => true
	indexes category
	indexes sub_category
end