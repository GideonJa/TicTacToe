class Game < ActiveRecord::Base

  def win?
    win_combinations = [
    [0,1,2],
    [3,4,5],
    [6,7,8],

    [0,3,6],
    [1,4,7],
    [2,5,8],

    [0,4,8],
    [2,4,6]]

    winner = nil
    win_combinations.each do |comb|
      unless winner
        if board[comb[0]] == board[comb[1]] &&
            board[comb[1]] == board[comb[2]] &&
            !board[comb[0]].blank?
          winner = board[comb[0]] 
        end
      end
    end
    return winner
  end

  def draw?
    !self.board.include?("") && !win?
  end

  def rank
    if win? && win? == "x"
      self.score = 10 - self.level
    elsif win? && win? == "o"
      self.score = level - 10
    elsif  draw?
      self.score = 0
    end
    return self.score  
  end

  def change_current_player
    self.current_player = switch_players
  end

  def switch_players
    current_player == "x" ? "o" : "x"
  end

  def build_tree_for_game
    next_player = switch_players
    game_won = false
    board.each_with_index do |slot, index|
      if slot.blank? && !game_won
        next_board = board.dup
        next_board[index] = current_player
        newName= self.name + index.to_s
        next_game = Game.new(board: next_board, current_player: next_player,  level:self.level.to_i+1 , name: newName, status: self.status)
        self.moves << next_game
        if next_game.win?
          next_game.score = next_game.win? =="x" ? 10 : -10 
          game_won = true
        else
          next_game.build_tree_for_game
        end
      end
    end
  end

  def next_move_ranking
    @best_move = self
    return rank if rank
    scores = []

    self.moves.each {|move| scores << move.next_move_ranking }
    win_game_index =
    if current_player == 'x'
      scores.each_with_index.max[1]
    else
      scores.each_with_index.min[1]
    end
    @best_move = self.moves[win_game_index]
    return scores[win_game_index]
    # return [moves[win_game_index].score,moves[win_game_index].board, moves[win_game_index].name]
  end
  def pick_a_corner
    self.board[[0,2,6,8][rand(4)]] = current_player
    self.change_current_player
    return self
  end

  def next_move
    if self.board.count("") != 9
      build_tree_for_game
      next_move_ranking
      @best_move
    else
      pick_a_corner 
    end
  end
end

