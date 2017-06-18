class AdminsController < ApplicationController
  def settings
  	@category = Category.new
  end

  def add_category
    begin
      Category.add_category(category_params)
      @success = true
    rescue Exception => e
      @success = false
      log_error(e, "Error occured in add_category action of AdminsController")
      flash_message("Error occured")
    end
  end

  private

  def category_params
  	params.require(:category).permit(:name, :cat_type)
  end
end
