module ApplicationHelper
	def message_div(message, class_name)
	    case class_name
	    when "error"
	      generate_message_div(message, "alert-danger")
	    when "success"
	      generate_message_div(message, "alert-success")
	    when "notice"
	      generate_message_div(message, "alert-info")
	    end
  	end

  	def generate_message_div(message, class_name)
    	raw(content_tag :div, raw("<a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">×</a>#{message}"), :class => "alert #{class_name.to_s} alert-dismissable")
  	end

end
