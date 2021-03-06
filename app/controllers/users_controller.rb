class UsersController < ApplicationController
    def index
        @users = User.all
    end

    def login
        @user = User.find_by login: get_login
        if @user == nil || !@user.checkPassword(get_password)
            flash[:error] = "Invalid login or password."
            redirect_to login_path
            return
        end
        session[:current_user_id] = @user[:id]
        session[:current_user_name] = @user[:login]
        redirect_to root_path
    end

    def logout
        session[:current_user_id] = nil
        session[:current_user_name] = nil
        @user = nil
        redirect_to root_path
    end

    def get_login_form
    end

    def new
    end

    def edit
    end

    def edit_password
    end

    def create
        req_params = register_params
        if !password_check
            flash[:error] = "Passwords aren't the same. "
        end
        if req_params[:login] == ""
            init_error
            flash[:error] = flash[:error] + "Login is empty. "
        end
        if req_params[:password] == ""
            init_error
            flash[:error] = flash[:error] + "Password is empty. "
        end
        if req_params[:email] == ""
            init_error
            flash[:error] = flash[:error] + "Email is empty. "
        end
        if flash[:error] != nil
            redirect_to new_user_path
        return
        end
        @user = User.new(register_params)
        unless @user.valid?
            flash[:error] = "Such user already exists. Try other login."
            redirect_to new_user_path
            return
        end
        @user.securePassword
        @user.save
        session[:current_user_id] = @user[:id]
        session[:current_user_name] = @user[:login]
        redirect_to @user
    end

    def show
        @user = User.find(params[:id])
        @leagues = League.where :user => @user
    end

    def update
        @user = User.find(params[:id])
        if @user.update :email => params.require(:email)
            redirect_to @user
            return
        end
        redirect_to edit_user_path
    end

    def update_password
        @user = User.find(params[:id])
        data = params.require(:data)
        if !@user.checkPassword(data[:current_password])
            flash[:error] = "Wrong password."
            redirect_to edit_password_path
            return
        end
        if data[:password] != data[:confirm_password]
            flash[:error] = "New passwords doesn't match."
            redirect_to edit_password_path
            return
        end
        @user.update_password(data[:password])
        redirect_to @user
    end

    def destroy
        if session[:current_user_id] == nil
            redirect_to root_path
            return
        end
        User.find(session[:current_user_id]).destroy_all
        redirect_to logout_path
    end

    private
        def init_error
            if flash[:error] == nil
                flash[:error] = ""
            end
        end

        def register_params
            params.require(:user).permit(:login, :password, :email)
        end

        def password_check
            pass = params.require(:user).permit(:confirm_password, :password)
            return pass[:confirm_password] == pass[:password]
        end

        def get_login
            params.require(:user).permit(:login)[:login]
        end

        def get_password
            params.require(:user).permit(:password)[:password]
        end
end
