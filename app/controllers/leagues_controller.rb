class LeaguesController < ApplicationController
    include LeaguesHelper

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

    def destroy
        @league = League.find(params[:id])
        if @league.user.id != session[:current_user_id]
            redirect_to show_league_path(@league)
            return
        end
        @league.destroy
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
        redirect_to show_league_path(@league)
    end

    def close
        @league = League.find(params[:id])
        @league.is_closed = true
        @league.save
        create_games(@league)
        redirect_to show_league_path(@league)
    end

    def open
        @league = League.find(params[:id])
        @league.is_closed = false
        destroy_all_games(@league)
        @league.save
        redirect_to show_league_path(@league)
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
