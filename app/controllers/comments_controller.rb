class CommentsController < ApplicationController
  before_action :find_commentable
  
  def create
  	begin
  		@comment = @commentable.comments.build(comment_params)
  		@comment.user = current_user
  		@comment.save
  		@success = true
  	rescue Exception => e
  		@success =  false
  		log_error(e, "Error occured in create action of CommentsController")
  	end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def comment_params
  	params.require(:comment).permit(:body)
  end

  def find_commentable
  	case
  	when params[:video_id].present?
  		@commentable = Video.find_by_id(params[:video_id])
  	when params[:comment_id].present?
  		@commentable = Comment.find_by_id[:comment_id]
  	when params[:blog_id].present?
  		@commentable = Blog.find_by_id[:blog_id]
  	end
  end
end
