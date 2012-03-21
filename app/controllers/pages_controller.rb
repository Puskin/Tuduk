class PagesController < ApplicationController

  before_filter :signed_in_redirect, except: [:home]
	layout :select_layout
  
  def home
    if signed_in?
      @task = current_user.tasks.build
      @categories = Category.find_all_by_user_id(current_user.id)
      if params[:search]
        @tasks = current_user.tasks.search(params[:search])
      else
        @tasks = Task.unfinished.find_all_by_user_id(current_user.id)
        @tasks_finished = Task.finished.find_all_by_user_id(current_user.id)
      end
    end
  end

  private

  	def select_layout
  		if signed_in? && action_name == "home"
  			"application"
  		else
  			"frontend"
  		end
  	end

end
