class SessionsController < ApplicationController

  before_filter :signed_in_redirect, only: [:new, :create] 

  layout "frontend", only: [:new]


	def new
	end

	def create
		user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
			sign_in user
      redirect_to root_path
      flash[:success] = "Welcome #{user.name}!" 
	  else
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
    	render 'new'
    end
	end

	def destroy
		sign_out
		redirect_to root_path
	end

end
