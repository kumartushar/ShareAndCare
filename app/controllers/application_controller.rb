class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :password, :gender])
  	devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end

  def log_error(e, message="")
    Rails.logger.error "#{message}: #{e.message}"
    e.backtrace[0..13].each { |line| Rails.logger.error line }
  end

  def flash_error(flash_message)
    flash[:error] =  t(flash_message)
  end

  def flash_notice(flash_message)
    flash[:notice] =  t(flash_message)
  end

  def flash_success(flash_message)
    flash[:success] =  t(flash_message)
  end

  def get_unescaped_search_text
    URI.unescape(params[:search_text].strip)
  end
end
