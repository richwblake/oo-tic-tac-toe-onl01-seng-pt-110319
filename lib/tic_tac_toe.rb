class TicTacToe
  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]

  def initialize
    @board = Array.new(9, " ")
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} \n-----------\n
    #{@board[3]} | #{@board[4]} | #{@board[5]} \n-----------\n
    #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index( input )
    input.to_i - 1
  end

  def move(position, player)
    @board[position] = player
  end

  def position_taken?( position )
    ["X", "O"].include?( @board[position] ) ? true : false
  end

  def valid_move?( position )
    @board[position] == " " && position >= 0 && position < 9 ? true : false
  end

  def turn_count
    spaces_occupied = 0
    @board.each { |spot| spaces_occupied += 1 if spot != " " }
    spaces_occupied
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn
    input = input_to_index( gets.chomp )
    if !position_taken?( input ) && valid_move?( input )
      move( input, current_player )
      display_board
    else
      turn
    end
  end

  def won?
    win = nil
    WIN_COMBINATIONS.each { |combo|
      if [@board[combo[0]], @board[combo[1]], @board[combo[2]]] == ["X", "X", "X"] || [@board[combo[0]], @board[combo[1]], @board[combo[2]]] == ["O", "O", "O"]
        win = combo
      end
    }
    win
  end

  def full?
    @board.none? { |spot| spot == " " }
  end

  def draw?
    !won? && full? ? true : false
  end

  def over?
    (draw? || won?)
  end

  def winner
    combo = won?
    combo ? @board[combo[0]] : nil
  end

  def play
    while ( !over? )
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end


end
