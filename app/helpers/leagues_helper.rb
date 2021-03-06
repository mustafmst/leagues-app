module LeaguesHelper
    def create_games(league)
        games_count = 0
        (0..league.contestants.count-2).to_a.each do |i|
            (i+1..league.contestants.count-1).to_a.each do |j|
                create_game(league.contestants[i], league.contestants[j], league)
                games_count += 1
            end
        end
        league.games_left = games_count
        league.save
    end

    def create_game(player1, player2, league)
        Game.create({
            :player_1 => player1.user.login,
            :player_2 => player2.user.login,
            :league => league,
            :is_finished => false,
            :score_1 => 0,
            :score_2 => 0
        })
    end

    def destroy_all_games(league)
        league.games.each do |g|
            g.destroy
        end
        league.contestants.each do |c|
            c.destroy
        end
    end
end
