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
    @active_page = "videos"
    @video = Video.new(video_params)
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

  private
    def set_video
      @video = Video.find(params[:id])
    end

    def video_params
      params.require(:video).permit(:title, :url)
    end
end
