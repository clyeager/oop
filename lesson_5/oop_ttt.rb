class Board
  attr_accessor :squares

  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    reset
  end

  def reset
    (1..9).each { |key| squares[key] = Square.new }
  end

  def []=(num, marker)
    squares[num].marker = marker
  end

  def unmarked_squares
    squares.keys.select { |k| squares[k].unmarked? }
  end

  def full?
    unmarked_squares.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
  def draw
    puts ""
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}" \
         "  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}" \
         "  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+------"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}" \
         "  |  #{@squares[9]}"
    puts "     |     |"
    puts ""
  end
  # rubocop:enable Metrics/AbcSize,Metrics/MethodLength

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.uniq.size == 1
  end

  public

  def detect_offensive_move(computer_marker)
    square = nil
    Board::WINNING_LINES.each do |line|
      markers = squares.values_at(*line).map(&:marker)
      if markers.count(computer_marker) == 2
        line.each do |key|
          square = key if squares[key].marker == Square::INITIAL_MARKER
        end
      end
    end
    square
  end

  def detect_defensive_move(human_marker)
    square = nil
    Board::WINNING_LINES.each do |line|
      markers = squares.values_at(*line).map(&:marker)
      if markers.count(human_marker) == 2
        line.each do |key|
          square = key if squares[key].marker == Square::INITIAL_MARKER
        end
      end
    end
    square
  end
end

class Square
  attr_accessor :marker

  INITIAL_MARKER = ' '

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Score
  attr_accessor :value

  WINNING_SCORE = 5

  def initialize
    self.value = 0
  end

  def increment_score
    self.value += 1
  end

  def winning_score?
    self.value == WINNING_SCORE
  end

  def to_s
    value
  end
end

class Player
  attr_accessor :marker, :name, :score

  @@marker_options = ('A'..'Z').to_a

  def initialize
    self.score = Score.new
  end

  def self.options
    @@marker_options
  end
end

class HumanPlayer < Player
  def initialize
    super
    set_name
    set_marker
    alter_marker_options
  end

  def set_name
    system('clear') || system('cls')
    puts "Welcome to Tic Tac Toe!"
    loop do
      puts "What is your name?"
      self.name = gets.chomp
      break if name.match(/[a-z]/i)
      puts "Please enter a valid name!"
      sleep(2)
    end
  end

  def set_marker
    loop do
      puts "You can be any letter. What letter would you like to be?"
      self.marker = gets.chomp.upcase
      break if marker.size == 1 && marker.match(/[A-Z]/)
      puts "Sorry, must pick a valid letter."
    end
  end

  def alter_marker_options
    @@marker_options.delete(marker)
  end

  def reset_marker
    self.marker = set_marker
  end
end

class ComputerPlayer < Player
  def initialize
    super
    set_name
    set_marker
  end

  def set_name
    self.name = ['Mario', 'Luigi', 'Peach', 'Boo'].sample
  end

  def set_marker
    self.marker = @@marker_options.sample
  end

  def reset_marker
    @marker = set_marker
  end
end

class TTTGame
  attr_reader :board, :human, :computer

  FIRST_TO_MOVE = ['human', 'computer', 'choose']

  private

  def initialize
    @board = Board.new
    @human = HumanPlayer.new
    @computer = ComputerPlayer.new
    @current_marker = set_first_player
    display_first_player
  end

  def set_first_player
    moves_first = FIRST_TO_MOVE.sample
    case moves_first
    when 'choose' then player_chooses
    when 'human' then human.marker
    else
      computer.marker
    end
  end

  def player_chooses
    answer = nil
    loop do
      puts "Would you like to go first?"
      answer = gets.chomp.downcase
      break if ['y', 'n', 'yes', 'no'].include?(answer)
    end
    return human.marker if ['y', 'yes'].include?(answer)
    computer.marker
  end

  def display_first_player
    if @current_marker == human.marker
      puts "Great, you will go first #{human.name}."
    else
      puts "#{computer.name} will go first."
    end
    sleep(2)
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe. Goodbye!"
  end

  def clear
    system('clear') || system('cls')
  end

  def display_current_scores
    puts "*Current Score*  #{human.name} : #{human.score.value} " \
    "#{computer.name} : #{computer.score.value}"
  end

  def display_markers
    puts "#{human.name}'s marker : #{human.marker}. #{computer.name}'s" \
    " marker : #{computer.marker}."
  end

  def display_board
    display_current_scores
    puts "#{human.name}'s marker : #{human.marker}. #{computer.name}'s" \
    " marker : #{computer.marker}."
    board.draw
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_choice
    puts "Choose a square (#{joinor(board.unmarked_squares)})"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_squares.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board[square] = human.marker
  end

  def offensive_move
    square = board.detect_offensive_move(computer.marker)
    board[square] = computer.marker if square
    square
  end

  def defensive_move
    square = board.detect_defensive_move(human.marker)
    board[square] = computer.marker if square
    square
  end

  def computer_choice
    loop do
      break if offensive_move || defensive_move
      if board.squares[5].unmarked?
        board[5] = computer.marker
      else
        board[board.unmarked_squares.sample] = computer.marker
      end
      break
    end
  end

  def human_turn?
    @current_marker == human.marker
  end

  def current_player_moves
    if human_turn?
      human_choice
      @current_marker = computer.marker
    else
      computer_choice
      @current_marker = human.marker
    end
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "It's a tie!"
    end

    puts "Please press any button to continue"
    gets
  end

  def update_scores
    case board.winning_marker
    when human.marker
      human.score.increment_score
    when computer.marker
      computer.score.increment_score
    end
  end

  def grand_champ
    return human.name if human.score.winning_score?
    return computer.name if computer.score.winning_score?
    nil
  end

  def end_of_round
    display_result
    update_scores
    reset
  end

  def wrapup
    display_grand_champ
    reset_scores
  end

  def display_human_champ
    puts "Congrats #{human.name}! You are the grand champ with " \
    "#{Score::WINNING_SCORE} wins!"
  end

  def display_computer_champ
    puts "Sorry, #{human.name}, #{computer.name} is the grand champ " \
    "with #{Score::WINNING_SCORE} wins!"
  end

  def display_grand_champ
    grand_champ == human.name ? display_human_champ : display_computer_champ
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n', 'yes', 'no'].include?(answer) && answer.match(/[a-z]/)
      puts "Sorry, must answer y or n"
    end

    answer == 'y' || answer == 'yes'
  end

  def reset
    board.reset
    @current_marker = human.marker
    clear
  end

  def joinor(squares, first_delim = ', ', second_delim = 'or')
    case squares.size
    when 1 then squares[0].to_s
    when 2 then "#{squares[0]} #{second_delim} #{squares[1]}"
    else
      "#{squares[0..-2].join(first_delim)} #{second_delim} #{squares[-1]}"
    end
  end

  def reset_scores
    human.score = Score.new
    computer.score = Score.new
  end

  public

  def play
    clear

    loop do
      display_board

      loop do
        current_player_moves
        break if board.someone_won? || board.full?
        clear_screen_and_display_board
      end

      end_of_round
      if grand_champ
        wrapup
        break unless play_again?
        clear
      end
    end

    display_goodbye_message
  end
end

game = TTTGame.new
game.play
