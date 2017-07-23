class ChannelsController < ApplicationController
  def create
  	begin
  		@channel = Channel.new(channel_params)
  		@channel.user_id = current_user.id
  		@channel.save
  		@success = true
  	rescue Exception => e
  		@success = false
  	end
  end


  private
  def channel_params
  	params.permit(:name)
  end
end
