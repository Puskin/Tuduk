class ApplicationController < ActionController::Base
	
  protect_from_forgery
  include SessionsHelper

  private

	  def reload_items
      user = User.find(current_user)
      @task = user.tasks.build if action_name != "destroy" && controller_name != "tasks"
      @tasks = user.tasks
      @categories = user.categories
    end


end
