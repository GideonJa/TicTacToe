class GameTree < ActiveRecord::Base


  def build_tree_for(game)
    next_player = (game.current_player == 'x' ? 'o' : 'x')
    game_won = false
    game.board.each_with_index do |slot, index|
      if !slot && !game_won
        next_board = game.board.dup
        next_board[index] = game.current_player
     
        next_game = Game.new(game.level+1, next_player, next_board)
        @@num +=1
        game.moves << next_game
        if next_game.win?
          next_game.score = next_game.win? =="x" ? 10 : -10 
          game_won = true
        else
          build_tree_for(next_game)
        end
      end
    end
  end

  def next_move(game)
    scores = []
    win_score =game.current_player == "x" ? 10 : -10 
    # is there a win in next move ?
    win_game_index = game.moves.map(&:score).index {|s| s == win_score}

    # return game.moves[win_game_index] if win_game_index
    game.moves.each do |move|
      a = move.rank
      scores << a
    end

    win_game_index =
    if game.current_player == 'x'
      scores.each_with_index.max[1]
    else
      scores.each_with_index.min[1]
    end
    return game.moves[win_game_index]
  end
end