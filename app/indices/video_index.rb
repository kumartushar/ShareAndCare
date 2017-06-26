ThinkingSphinx::Index.define :video, :with => :active_record do
	indexes title

	set_property :enable_star => 1
  	set_property :min_infix_len => 1
end