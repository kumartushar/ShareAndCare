class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @active_page = "videos"
    @videos = Video.all
    respond_with(@videos)
  end

  def show
    @active_page = "videos"
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

  def create
    # http://cloudinary.com/documentation/rails_video_upload#rails_video_upload_examples
    # http://cloudinary.com/documentation/upload_videos
    # http://cloudinary.com/documentation/video_management
    # http://cloudinary.com/documentation/rails_video_manipulation
    @active_page = "videos"
    video_public_id = "video_#{SecureRandom.urlsafe_base64}"
    response = Cloudinary::Uploader.upload(params[:video][:target_file], :resource_type => :video, :public_id => video_public_id)
    # Cloudinary::Uploader.upload_large(params[:video][:target_file], :resource_type => :video, :public_id => "my_folder/my_sub_folder/myvideo1", :eager => [{:width => 300, :height => 300, :crop => :pad}], :eager_async => true, :eager_notification_url => "http://c45a1454.ngrok.io/videos/transform_notification")
    @video = Video.new({title: video_params[:title]})
    @video.video_details = response
    @video.save
    respond_with(@video)
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

  def transform_notification
    puts "params = #{params}"
  end

  private
    def set_video
      @video = Video.find(params[:id])
    end

    def video_params
      params.require(:video).permit(:title, :target_file)
    end
end