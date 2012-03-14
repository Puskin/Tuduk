class PagesController < ApplicationController

  before_filter :redirect_if_signed, except: [:home]
	layout :select_layout
  
  def home
  end

  private

  	def redirect_if_signed
      redirect_to root_path if signed_in?
  	end

  	def select_layout
  		if signed_in? && action_name == "home"
  			"application"
  		else
  			"frontend"
  		end
  	end

end
