class GamesController < ApplicationController
  include GamesHelper
  def save
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    save_score(@game, params.require(:game)[:score_1], params.require(:game)[:score_2])
    add_points(@game)
    redirect_to show_league_path(@game.league)
  end
end
