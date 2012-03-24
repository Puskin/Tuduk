class PagesController < ApplicationController

  before_filter :signed_in_redirect, except: [:home]
	layout :select_layout
  
  def home
    if signed_in?
      user = User.find(current_user)
      @task = user.tasks.build
      @categories = user.categories
      if params[:search]
        @tasks = current_user.tasks.search(params[:search])
      else
        @tasks = user.tasks
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
