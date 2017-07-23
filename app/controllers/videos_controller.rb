class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]
  before_action :check_channel_presence,  only: [:new]

  respond_to :html

  def index
    @active_page = "videos"
    @videos = Video.all
    @is_create_channel = current_user.channel.blank?
    respond_with(@videos)
  end

  def show
    @active_page = "videos"
    @video.no_of_views += 1
    @video.save
    respond_with(@video)
  end

  def new
    @active_page = "videos"
    @video = Video.new
    respond_with(@video)
  end

  def edit
    @active_page = "videos"
  end

  def save_draft
    @video = Video.new(video_params)
    @video.video_details = JSON.parse(params[:video][:video_details])
    @video.channel_id = current_user.channel.id
    @video.save
  end

  def create
    # This comment part specifies how to perform server side uploading
    # http://cloudinary.com/documentation/rails_video_upload#rails_video_upload_examples
    # http://cloudinary.com/documentation/upload_videos
    # http://cloudinary.com/documentation/video_management
    # http://cloudinary.com/documentation/rails_video_manipulation
    
    # video_public_id = "video_#{SecureRandom.urlsafe_base64}"
    # response = Cloudinary::Uploader.upload(params[:video][:target_file], :resource_type => :video, :public_id => video_public_id)
    # Cloudinary::Uploader.upload_large(params[:video][:target_file], :resource_type => :video, :public_id => "my_folder/my_sub_folder/myvideo1", :eager => [{:width => 300, :height => 300, :crop => :pad}], :eager_async => true, :eager_notification_url => "http://c45a1454.ngrok.io/videos/transform_notification")
    @active_page = "videos"
    if params[:id].blank?
      @video = Video.new(video_params)
    else
      @video = Video.find(params[:id])
      @video.update_attributes(video_params)
    end
    @video.save
    redirect_to "/videos"
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

  def search
    @active_page = "videos"
    @search_text = get_unescaped_search_text
    @search_result = Video.search ThinkingSphinx::Query.escape("*#{@search_text}*")
  end

  private
    def set_video
      @video = Video.where(access_code: params[:id]).first
    end

    def get_tag_string(tag_h)
      tag_h.blank? ? "" : tag_h.values.join("#~#")
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