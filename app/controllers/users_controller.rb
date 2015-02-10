class UsersController < ApplicationController
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
end
