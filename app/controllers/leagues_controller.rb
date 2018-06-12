class LeaguesController < ApplicationController
    def index
        @leagues = League.all
    end

    def new
        if session[:current_user_id] == nil
            redirect_to root_path
            return
        end
    end

    def create
        if session[:current_user_id] == nil
            redirect_to root_path
            return
        end
        if params.require(:league)[:name] == ""
            flash[:error] = "League name is empty."
            redirect_to new_league_path
            return
        end
        @league = League.create(league_params)
        redirect_to leagues_path
    end

    def show
        @league = League.find(params[:id])
    end

    def add_contestant
        @league = League.find(params[:id])
        if @league.is_full 
            redirect_to leagues_path
            return
        end
        @user = User.find(params[:user_id])
        if @league == nil || @user == nil || @league.is_user_sign_in(@user[:id])
            redirect_to leagues_path
            return
        end
        @contestant = Contestant.create({
            :league => @league,
            :user => @user,
            :has_won => false,
            :points => 0
        })
        redirect_to leagues_path :id => @league
    end

    private
        def league_params
            form_params = params.require(:league)
            return {
                    :name => form_params[:name], 
                    :user => User.find(session[:current_user_id]),
                    :max_contestants => form_params[:max_contestants]
            }
        end
end
