class UsersController < ApplicationController
  def index
  end

  def login
    @user = User.find_by login: get_login
    if @user == nil || @user[:password] != get_password
      flash[:error] = "Invalid login or password."
      redirect_to login_path
      return
    end
    session[:current_user_id] = @user[:id]
    session[:current_user_name] = @user[:login]
    redirect_to root_path
  end

  def get_login_form
  end

  def logout
    session[:current_user_id] = nil
    session[:current_user_name] = nil
    @user = nil
    redirect_to root_path
  end

  def create
    @user = User.new(register_params)
    unless @user.valid?
      flash[:error] = "Such user already exists. Try other login."
      redirect_to new_user_path
      return
    end
    @user.save
    session[:current_user_id] = @user[:id]
    session[:current_user_name] = @user[:login]
    redirect_to @user
  end

  def new
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private
    def register_params
      params.require(:user).permit(:login, :password)
    end

    def get_login
      params.require(:user).permit(:login)[:login]
    end

    def get_password
      params.require(:user).permit(:password)[:password]
    end
end
