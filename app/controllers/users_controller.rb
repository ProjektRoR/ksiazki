class UsersController < ApplicationController

  #before_action :logged_in_user, only: [:edit, :update]
  #before_action :correct_user,   only: [:edit, :update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(session[:user_id])
  end

  def create
    @user = User.new(params[:user])    # Not the final implementation!
    @user.access= 1
    if @user.save
      log_in @user
      flash[:success] = "gratuluje pozytywnego zalogowania"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(session[:user_id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profil zaktualizowany"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
