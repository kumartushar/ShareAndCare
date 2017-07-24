class ChannelsController < ApplicationController
  
  ##Action:           create
  # Method:           POST
  # Purpose:          This action contains functionality for creating a video channel
  # Author:           Tushar Hawaldar
  # Date:             July 2017
  # Url:              /channel
  # Request Format:   JS 
  # Output Success Response :
  #   Renders create.js.erb
  ##
  def create
  	begin
  		@channel = Channel.new(channel_params)
  		@channel.user_id = current_user.id
  		@channel.save
  		@success = true
  	rescue Exception => e
  		@success = false
      log_error(e, "Error occured in Search action of BlogsController")
  	end
  end


  private
  def channel_params
  	params.permit(:name)
  end
end
