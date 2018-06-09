class UsersController < ApplicationController
  def index
  end

  def login
  end

  def get_login_form
  end

  def logout
    session[:current_user] = nil
    redirect_to '/'
  end

  def create
    @user = User.new(register_params)

    unless @user.valid?
      render json: {
        status: 422,
        message: "Validation error", 
        errors: @user.errors    
      }.to_json
      return
    end
    session[:current_user] = @user.login
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
