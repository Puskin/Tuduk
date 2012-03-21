class ApplicationController < ActionController::Base
	
  protect_from_forgery
  include SessionsHelper

  private

	  def reload_items
      @task = current_user.tasks.build if action_name != "destroy" && controller_name != "tasks"
      @tasks = Task.unfinished.find_all_by_user_id(current_user.id)
      @tasks_finished = Task.finished.find_all_by_user_id(current_user.id)
      @categories = Category.find_all_by_user_id(current_user.id)
    end


end
