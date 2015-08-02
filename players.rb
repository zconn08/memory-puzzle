
class AI

  def initialize
    @known_values = {}
    @ungessed_positions = [] #random list
    @last_turn = :first_turn
  end

  def prompt_two_inputs
    if @last_turn == :first_turn
      return @last_guess = random_guess
    end
    if educated_guess.nil? && @last_turn == :second_turn
      @last_guess = random_guess
    else
      @last_guess = educated_guess
    end
  end

  def random_guess
    @unguessed_positions.pop
  end

  def educated_guess
    if @known_values.include?(@current_str)
      return @known_values[@current_str]
    else
      return nil
    end
  end

  def ask_difficulty
    @x = (2..6).step(2).to_a.sample
    @y = (2..8).step.to_a.sample
    @unguessed_positions = []
    @x.times do |x|
      @y.times do |y|
          @unguessed_positions << [x,y]
      end
    end
    @unguessed_positions.shuffle!
    [@x, @y]
  end

  def receive_feedback (str,type)
    @last_turn = type
    @current_str = str
    @known_values[@current_str] = @last_guess
  end

end

class HumanPlayer
  def prompt_two_inputs
    input = gets.chomp
    /(?<x>\d+)\D+(?<y>\d+)/ =~ input
    [x.to_i, y.to_i]
  end

  def ask_difficulty
    puts "Please select difficulty (row x col)"
    input = [3, 4]
    loop do
      input = prompt_two_inputs
      break if (input[0] * input[1] % 2) == 0
      puts "Please select valid board size. Needs to be mulitple of 2."
    end
    [input[0], input[1]]
  end
  def receive_feedback (str,type)
  end
end
