class UsersController < ApplicationController

  before_filter :signed_in_user,      except: [:new, :create]
  before_filter :signed_in_redirect,  only:   [:new, :create]
  before_filter :correct_user,        only:   [:edit, :update, :destroy, :show]
  
  layout "frontend",                  only:   [:new]


  
  def show
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Tuduk."
      redirect_to @user
    else
      render action: "new"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      sign_in @user
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url   
  end


  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

end
