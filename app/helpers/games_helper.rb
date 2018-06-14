module GamesHelper
    def save_score(game, score1, score2)
        game.score_1 = score1
        game.score_2 = score2
        game.is_finished = true
        game.save
    end

    def add_points(game)
        if game.score_1 == game.score_2
            game.league.contestants.each do |c|
                if c.user.login == game.player_1 || c.user.login == game.player_2
                    c.points += 1
                    c.save
                end
            end
        else
            winner = game.player_1
            if game.score_2 > game.score_1
                winner = game.player_2
            end
            game.league.contestants.each do |c|
                if c.user.login == winner
                    c.points += 2
                    c.save
                end
            end
        end
    end
end
