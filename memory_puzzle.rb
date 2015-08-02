require "./board.rb"
require "./card.rb"
require "./players.rb"

class Game

  attr_reader :num_row, :num_col

  def initialize(player = HumanPlayer.new)
    @player = player
    @counter = 0
    set_board
    @board = Board.new(@num_row, @num_col)
  end

  def set_board
    board_options = @player.ask_difficulty
    @num_row = board_options[0]
    @num_col = board_options[1]
    @limit = @num_row * @num_col
    puts "Good luck, you must solve this within #{@limit} turns"
    sleep(1)
  end


  def play
    until @board.won? || @counter == @limit
      system("clear")
      @counter += 1
      puts "This is turn #{@counter} out of #{@limit}"
      puts "*" * 15
      @board.render
      loop do
        puts "Please guess a first position"
        @input_one = @player.prompt_two_inputs
        break if @board.valid_move?@input_one
        puts "Invalid Move!"
      end
      @previous_guess = @board.reveal(@input_one)
      @player.receive_feedback(@previous_guess,:first_turn)
      @board.render
      loop do
        puts "Please guess a second position"
        @input_two = @player.prompt_two_inputs
        break if @board.valid_move?@input_two
        puts "Invalid Move!"
      end
      @second_guess = @board.reveal(@input_two)
      @player.receive_feedback(@second_guess,:second_turn)
      @board.render

      if @previous_guess == @second_guess
        puts "Nice! You got a match"
      else
        @board.hide(@input_one)
        @board.hide(@input_two)
        puts "No Match!"
      end
      sleep(3)
      @second_guess = @previous_guess = nil
    end

    if @board.won?
      puts "Congratulations! You won the game in #{@counter} turns!"
    else
      puts "sorry, you took too many turns!"
    end
  end


end


if __FILE__ == $PROGRAM_NAME
  # Game.new(AI.new).play
  Game.new.play
end
