class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy, :like_dislike]
  before_action :check_channel_presence,  only: [:new]

  respond_to :html

  ##Action:           index
  # Method:           GET
  # Url:              /videos
  # Purpose:          This action contains functionality of listing videos for user
  # Author:           Tushar Hawaldar
  # Date:             June 2017
  # Request Format:   HTML 
  # Output Success Response :
  #   Renders index.html.erb
  ##
  def index
    begin
      @active_page = "videos"
      @videos = Video.all
      @is_create_channel = current_user.channel.blank?
      respond_with(@videos)
    rescue Exception => e
      log_error(e, "Error occured in Index action of VideosController")
      flash_error(t('videos.index_page_load_error'))
    end
  end

  ##Action:           show
  # Method:           GET
  # Url:              /videos/:id
  # Purpose:          This action contains functionality of displaying and playing video
  # Author:           Tushar Hawaldar
  # Date:             June 2017
  # Request Format:   HTML
  # Output Success Response :
  #   Renders show.html.erb
  ##
  def show
    begin
      @active_page = "videos"
      @video.no_of_views += 1
      @video.save
      respond_with(@video)
    rescue Exception => e
      log_error(e, "Error occured in Show action of VideosController")
      flash_error(t('videos.show_page_load_error'))
    end
  end

  ##Action:           new
  # Method:           GET
  # Url:              /videos/new
  # Purpose:          This action contains functionality of providing an interface to upload video to system
  # Author:           Tushar Hawaldar
  # Date:             June 2017
  # Request Format:   HTML
  # Output Success Response :
  #   Renders new.html.erb
  ##
  def new
    begin
      @active_page = "videos"
      @video = Video.new
      respond_with(@video)
    rescue Exception => e
      log_error(e, "Error occured in New action of VideosController")
      flash_error(t('videos.new_page_load_error'))
    end
  end

  def edit
    @active_page = "videos"
  end

  ##Action:           save_draft
  # Method:           POST
  # Url:              /save_drafts
  # Purpose:          This action contains functionality of saving a video as draft
  # Author:           Tushar Hawaldar
  # Date:             July 2017
  # Request Format:   JS
  # Output Success Response :
  #   Renders save_draft.js.erb
  ##
  def save_draft
    begin
      @video = Video.new(video_params)
      @video.video_details = JSON.parse(params[:video][:video_details])
      @video.channel_id = current_user.channel.id
      @video.save
      @success = true
    rescue Exception => e
      @success = false
      log_error(e, "Error occured in save_draft action of VideosController")
    end
  end

  ##Action:           create
  # Method:           POST
  # Url:              /videos
  # Purpose:          This action contains functionality of publishing a video
  # Author:           Tushar Hawaldar
  # Date:             July 2017
  # Request Format:   HTML
  # Output Success Response :
  #   Redirect to index page
  ##
  def create
    # This comment part specifies how to perform server side uploading
    # http://cloudinary.com/documentation/rails_video_upload#rails_video_upload_examples
    # http://cloudinary.com/documentation/upload_videos
    # http://cloudinary.com/documentation/video_management
    # http://cloudinary.com/documentation/rails_video_manipulation
    
    # video_public_id = "video_#{SecureRandom.urlsafe_base64}"
    # response = Cloudinary::Uploader.upload(params[:video][:target_file], :resource_type => :video, :public_id => video_public_id)
    # Cloudinary::Uploader.upload_large(params[:video][:target_file], :resource_type => :video, :public_id => "my_folder/my_sub_folder/myvideo1", :eager => [{:width => 300, :height => 300, :crop => :pad}], :eager_async => true, :eager_notification_url => "http://c45a1454.ngrok.io/videos/transform_notification")
    begin
      @active_page = "videos"
      if params[:id].blank?
        @video = Video.new(video_params)
      else
        @video = Video.find(params[:id])
        @video.update_attributes(video_params)
      end
      @video.save
    rescue Exception => e
      log_error(e, "Error occured in Create action of VideosController")
      flash_error(t('videos.create_page_error'))
    ensure
      redirect_to "/videos"
    end
  end

  def update
    @active_page = "videos"
    @video.update(video_params)
    respond_with(@video)
  end

  def destroy
    @active_page = "videos"
    @video.destroy
    respond_with(@video)
  end

  #Action:            search
  # Method:           GET
  # Url:              /videos/search
  # Purpose:          This action contains functionality of searching videos matching search text in Sphinx SE
  # Author:           Tushar Hawaldar
  # Date:             June 2017
  # Request Format:   JS
  # Output Success Response :
  #   search.js.erb
  ##
  def search
    begin
      @active_page = "videos"
      @search_text = get_unescaped_search_text
      @search_result = Video.search ThinkingSphinx::Query.escape("*#{@search_text}*")
      @success = true
    rescue Exception => e
      @success = false
      log_error(e, "Error occured in search action of VideosController")
    end
  end

  #Action:            like_dislike
  # Method:           POST
  # Url:              /videos/:id/like_dislike
  # Purpose:          This action contains functionality of keeping track of like/dislike to a video
  # Author:           Tushar Hawaldar
  # Date:             July 2017
  # Request Format:   JS
  # Output Success Response :
  #   like_dislike.js.erb
  ##
  def like_dislike
    begin
      params[:action] == "like" ? @video.no_of_likes += 1 : @video.no_of_dislikes += 1
      @video.save
      @success = true
    rescue Exception => e
      @success = false
      log_error(e, "Error occured in like_dislike action of VideosController")
    end
  end

  private
    def set_video
      @video = Video.get_by_access_code(params[:id])
      if @video.blank?
        flash[:error] = t('videos.video_not_found')
        redirect_to "/videos"
      end
    end

    def video_params
      params.require(:video).permit(:title, :description, :category, :tags, :access_code, :workflow_state)
    end

    def check_channel_presence
      if current_user.channel.blank?
        flash[:notice] = t('videos.create_channel')
        redirect_to "/videos"
      end
    end
end