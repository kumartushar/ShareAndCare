class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  respond_to :html

  ##Action:           index
  # Method:           GET
  # Purpose:          This action contains functionality for listing all the blogs.
  # Author:           Tushar Hawaldar
  # Date:             -
  # Url:              /blogs
  # Request Format:   HTML 
  # Output Success Response :
  #   Renders index.html.erb
  ## 
  def index
    begin
      @active_page = "blogs"
      @blogs = Blog.all
      respond_with(@blogs)
    rescue Exception => e
      log_error(e, "Error occured in Index action of BlogsController")
      flash_error(t('blogs.index_page_load_error'))
    end
  end

  ##Action:           show
  # Method:           GET
  # Purpose:          This action contains functionality for displaying blog content.
  # Author:           Tushar Hawaldar
  # Date:             -
  # Url:              /blogs/:id
  # Request Format:   HTML 
  # Output Success Response :
  #   Renders show.html.erb
  ## 
  def show
    begin
      @active_page = "blogs"
      respond_with(@blog)
    rescue Exception => e
      log_error(e, "Error occured in Show action of BlogsController")
      flash_error(t('blogs.show_page_load_error'))
    end
  end

  ##Action:           new
  # Method:           GET
  # Purpose:          This action contains functionality for providing an interface to create blog
  # Author:           Tushar Hawaldar
  # Date:             -
  # Url:              /blogs/new
  # Request Format:   HTML 
  # Output Success Response :
  #   Renders new.html.erb
  ## 
  def new
    begin
      @active_page = "blogs"
      @blog = Blog.new
      respond_with(@blog)
    rescue Exception => e
      log_error(e, "Error occured in New action of BlogsController")
      flash_error(t('blogs.new_page_load_error'))
    end
  end

  ##Action:           edit
  # Method:           GET
  # Purpose:          This action contains functionality for providing an interface to edit blog
  # Author:           Tushar Hawaldar
  # Date:             -
  # Url:              /blogs/:id/edit
  # Request Format:   HTML 
  # Output Success Response :
  #   Renders edit.html.erb
  ## 
  def edit
    begin
      @active_page = "blogs"
    rescue Exception => e
      log_error(e, "Error occured in Edit action of BlogsController")
      flash_error(t('blogs.edit_page_load_error'))
    end
  end

  ##Action:           create
  # Method:           POST
  # Purpose:          This action contains functionality of creating a blog
  # Author:           Tushar Hawaldar
  # Date:             -
  # Url:              /blogs
  # Request Format:   HTML 
  ## 
  def create
    begin
      @active_page = "blogs"
      @blog = Blog.new(blog_params)
      @blog.save
      respond_with(@blog)
    rescue Exception => e
      log_error(e, "Error occured in Create action of BlogsController")
      flash_error(t('blogs.create_page_error'))
    end
  end

  ##Action:           update
  # Method:           PATCH
  # Purpose:          This action contains functionality of updating blog content
  # Author:           Tushar Hawaldar
  # Date:             -
  # Url:              /blogs/:id
  # Request Format:   HTML 
  ## 
  def update
    begin
      @active_page = "blogs"
      @blog.update(blog_params)
      respond_with(@blog)
    rescue Exception => e
      log_error(e, "Error occured in Update action of BlogsController")
      flash_error(t('blogs.update_page_error'))
    end
  end

  ##Action:           destroy
  # Method:           DELETE
  # Purpose:          This action contains functionality for deleting a blog
  # Author:           Tushar Hawaldar
  # Date:             -
  # Url:              /blogs/:id
  # Request Format:   HTML 
  ## 
  def destroy
    @active_page = "blogs"
    @blog.destroy
    respond_with(@blog)
  end

  ##Action:           search
  # Method:           GET
  # Purpose:          This action contains functionality for searching the blog matching search text from Sphinx SE
  # Author:           Tushar Hawaldar
  # Date:             -
  # Url:              /blogs/search
  # Request Format:   JS 
  # Output Success Response :
  #   Renders search.js.erb
  ## 
  def search
    begin
      @active_page = "blogs"
      @search_text = get_unescaped_search_text
      @search_result = Blog.search ThinkingSphinx::Query.escape("*#{@search_text}*")
    rescue Exception => e
      log_error(e, "Error occured in Search action of BlogsController")
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
