class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    begin
      @active_page = "blogs"
      @blogs = Blog.all
      respond_with(@blogs)
    rescue Exception => e
      log_error(e, "Error occured in index action of BlogsController")
      flash_message("Error occured")
    end
  end

  def show
    @active_page = "blogs"
    respond_with(@blog)
  end

  def new
    @active_page = "blogs"
    @blog = Blog.new
    respond_with(@blog)
  end

  def edit
    @active_page = "blogs"
  end

  def create
    @active_page = "blogs"
    @blog = Blog.new(blog_params)
    @blog.save
    respond_with(@blog)
  end

  def update
    @active_page = "blogs"
    @blog.update(blog_params)
    respond_with(@blog)
  end

  def destroy
    @active_page = "blogs"
    @blog.destroy
    respond_with(@blog)
  end

  def search
    begin
      @active_page = "blogs"
      @search_text = get_unescaped_search_text
      @search_result = Blog.search ThinkingSphinx::Query.escape("*#{@search_text}*")
    rescue Exception => e
      log_error(e, "Error occured in search action of BlogsController")
      flash_message("Error occured")
    end
  end

  private
    def set_blog
      @blog = Blog.find(params[:id])
    end

    def blog_params
      params.require(:blog).permit(:title, :category, :sub_category, :description, :avatar, :published_status, :published_on)
    end
end
