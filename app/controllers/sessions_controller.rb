class SessionsController < ApplicationController

  before_filter :redirect_if_signed, only: [:new, :create] 

  layout "frontend", only: [:new]


	def new
	end

	def create
		user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
			sign_in user
      redirect_to user
	  else
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
    	render 'new'
    end
	end

	def destroy
		sign_out
		redirect_to root_path
	end

	private

		def redirect_if_signed
      redirect_to root_path if signed_in?
  	end

end
