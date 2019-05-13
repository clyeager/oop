class Move
  def initialize(name)
    @name = name
  end

  def to_s
    @name
  end

  private

  def rock?
    @name == 'rock'
  end

  def paper?
    @name == 'paper'
  end

  def scissors?
    @name == 'scissors'
  end

  def spock?
    @name == 'spock'
  end

  def lizzard?
    @name == 'lizzard'
  end
end

class Rock < Move
  attr_reader :name

  @@name = 'rock'
  WINS_AGAINST = ['scissors', 'lizzard']

  def initialize
    @name = 'rock'
  end

  def >(other_move)
    WINS_AGAINST.include?(other_move.name)
  end
end

class Paper < Move
  attr_reader :name

  @@name = 'paper'
  WINS_AGAINST = ['rock', 'spock']

  def initialize
    @name = 'paper'
  end

  def >(other_move)
    WINS_AGAINST.include?(other_move.name)
  end
end

class Scissors < Move
  attr_reader :name

  @@name = 'scissors'
  WINS_AGAINST = ['paper', 'lizzard']

  def initialize
    @name = 'scissors'
  end

  def >(other_move)
    WINS_AGAINST.include?(other_move.name)
  end
end

class Spock < Move
  attr_reader :name

  @@name = 'spock'
  WINS_AGAINST = ['rock', 'scissors']

  def initialize
    @name = 'spock'
  end

  def >(other_move)
    WINS_AGAINST.include?(other_move.name)
  end
end

class Lizzard < Move
  attr_reader :name

  @@name = 'lizzard'
  WINS_AGAINST = ['spock', 'paper']

  def initialize
    @name = 'lizzard'
  end

  def >(other_move)
    WINS_AGAINST.include?(other_move.name)
  end
end

class MoveHistory
  attr_accessor :history, :wins, :losses
  attr_reader :owner

  STRING_CHOICES = ['rock', 'paper', 'scissors', 'spock', 'lizzard']

  def initialize(owner)
    @owner = owner
    @history = Hash.new(0)
    @wins = []
    @losses = []
  end

  def add_to_history(choice)
    history[choice] += 1
  end

  def display_history
    puts ''
    puts "**#{owner}'s history:**"
    history.each { |round, count| puts "#{round} : #{count}" }
    puts ''
  end

  def add_win(move)
    wins << move
  end

  def add_loss(move)
    losses << move
  end
end

class HumanMoveHistory < MoveHistory
  attr_accessor :win_percentages

  def initialize(owner)
    super
    @win_percentages = Hash.new(0)
  end

  def determine_best_options
    return nil unless wins.size > 1
    calc_win_percentages
    arr = win_percentages.sort_by { |_, v| v }
    arr.last(2).flatten.select { |el| el.is_a?(String) }
  end

  private

  def calc_win_percentages
    STRING_CHOICES.each do |choice|
      if history.include?(choice)
        total_times_chosen = wins.count(choice) + losses.count(choice)
        times_won = wins.count(choice)
        percentage_won = times_won / total_times_chosen.to_f
        win_percentages[choice] = percentage_won
      end
    end
  end
end

class ComputerMoveHistory < MoveHistory
  attr_accessor :new_options, :loss_percentages

  def initialize(owner)
    super
    @loss_percentages = Hash.new(0)
    @new_options = []
  end

  def choose
    if history.size > 1
      calc_loss_percentages
      examine_choices
      new_options.sample
    else
      STRING_CHOICES.sample
    end
  end

  private

  def calc_loss_percentages
    STRING_CHOICES.each do |choice|
      total_times_chosen = wins.count(choice) + losses.count(choice)
      times_lost = losses.count(choice)
      percentage_lost = times_lost / total_times_chosen.to_f
      loss_percentages[choice] = percentage_lost
    end
  end

  def examine_choices
    loss_percentages.each do |choice, percent|
      if percent <  0.50
        new_options << choice << choice
      else
        new_options << choice
      end
    end
  end
end

class Player
  attr_accessor :move, :name, :score, :history
  MAX_SCORE = 10
  PLAYER_CHOICES = { ['r', 'rock'] => Rock, ['p', 'paper'] => Paper,
                     ['sc', 'scissors'] => Scissors, ['sp', 'spock'] => Spock,
                     ['l', 'lizzard'] => Lizzard }

  def initialize
    self.score = 0
    set_name
  end

  def change_score
    self.score += 1
  end

  def reset_score
    self.score = 0
  end
end

class Human < Player
  def initialize
    super
    @history = HumanMoveHistory.new(name)
  end

  def set_name
    n = ""
    loop do
      system 'clear'
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "sorry, must enter a value."
    end
    self.name = n
  end

  def best_options
    best = history.determine_best_options
    return nil if best.nil?
    puts "**Your most wins come from choosing either #{best[0]} " \
    "or #{best[1]}**"
  end

  def choose
    choice = nil
    loop do
      puts ''
      puts "Please choose rock, paper, scissors, spock, or lizzard."
      choice = gets.chomp
      puts ''
      break if PLAYER_CHOICES.keys.flatten.include?(choice.downcase)
      puts "Sorry, invalid choice."
    end
    choice = determine_choice(choice.downcase)
    PLAYER_CHOICES.each { |st, ob| self.move = ob.new if st.include?(choice) }
  end

  def reset_history
    self.history = HumanMoveHistory.new(name)
  end

  private

  # rubocop:disable Metrics/CyclomaticComplexity
  def determine_choice(choice)
    return choice unless choice.size < 3
    case choice
    when 'r' then 'rock'
    when 'p' then 'paper'
    when 'sc' then 'scissors'
    when 'sp' then 'spock'
    when 'l' then 'lizzard'
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity
end

class Computer < Player
  def initialize
    super
    @history = ComputerMoveHistory.new(name)
  end

  def set_name
    self.name = ['Mario', 'Luigi', 'Peach', 'Toad', 'Boo'].sample
  end

  def choose
    choice = history.choose
    PLAYER_CHOICES.each { |st, ob| self.move = ob.new if st.include?(choice) }
  end

  def reset_history
    self.history = ComputerMoveHistory.new(name)
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  private

  def display_welcome_message
    puts ''
    puts "**Welcome to Rock, Paper, Scissors #{human.name}!**"
    puts "**The first to win 10 games is the Grand Champ!"
  end

  def display_goodbye_message
    puts "Thanks for player Rock, Paper, Scissors!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif computer.move > human.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def increment_score
    human.change_score if human.move > computer.move
    computer.change_score if computer.move > human.move
  end

  def update_human_history
    if human.move > computer.move
      human.history.add_win(human.move.name)
    else
      human.history.add_loss(human.move.name)
    end
  end

  def update_computer_history
    if human.move > computer.move
      computer.history.add_loss(computer.move.name)
    else
      computer.history.add_win(computer.move.name)
    end
  end

  def display_scores
    puts "**Score** #{human.name} : #{human.score} #{computer.name} " \
    ": #{computer.score}"
  end

  def grand_champ
    return human.name if human.score == Player::MAX_SCORE
    return computer.name if computer.score == Player::MAX_SCORE
  end

  def reset
    human.reset_score
    computer.reset_score
    computer.set_name
    human.reset_history
    computer.reset_history
  end

  def human_champ_message
    puts ''
    puts "Congrats! Not only did you win this round #{grand_champ}," \
         " you are also the Grand Champ with 10 wins!"
    puts ''
  end

  def computer_champ_message
    puts "Sorry #{human.name}, the Grand Champ is #{grand_champ} with " \
         "10 wins! "
  end

  def display_grand_champ
    human_champ_message if grand_champ == human.name
    computer_champ_message if grand_champ == computer.name
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n', 'yes', 'no'].include?(answer.downcase)
      puts "Sorry, must be y or n."
    end
    return true if answer.downcase.start_with?('y')
    return false if answer.downcase .start_with?('n')
  end

  def pause
    puts ''
    puts "**Please press enter to continue**"
    gets
  end

  public

  def play
    display_welcome_message

    loop do
      human.best_options if human.best_options
      human.choose
      computer.choose
      display_moves
      display_winner
      increment_score
      human.history.add_to_history(human.move.name)
      computer.history.add_to_history(computer.move.name)
      update_human_history
      update_computer_history
      if grand_champ
        puts display_grand_champ
        reset
        break unless play_again?
      end
      pause
      system 'clear'
      display_scores
      human.history.display_history
      computer.history.display_history
      puts ''
    end
    display_goodbye_message
  end
end

RPSGame.new.play
