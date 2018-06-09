class UsersController < ApplicationController
  def index
  end

  def login
  end

  def create
    @user = User.new(register_params)
    @user.save

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
end
