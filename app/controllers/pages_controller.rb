class PagesController < ApplicationController

  before_filter :signed_in_redirect, except: [:home]
	layout :select_layout
  
  def home

    if signed_in?
      @user = current_user
      @tasks = @user.tasks
      @task = current_user.tasks.build
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
