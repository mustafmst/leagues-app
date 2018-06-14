module LeaguesHelper
    def create_games(league)
        (0..league.contestants.count-2).to_a.each do |i|
            (i..league.contestants.count-1).to_a.each do |j|
                create_game(league.contestants[i], league.contestants[j])
            end
        end
        league.games_left = league.contestants.count*(league.contestants.count-1)
        league.save
    end

    def create_game(player1, player2)
    end
end
