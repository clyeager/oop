module Displayable
  def clear
    system('clear') || system('cls')
  end

  def display_welcome_message
    puts "Welcome to Twenty-One #{human.name}! Your dealer is " \
    "#{dealer.name}. Good luck!"
    puts ''
    puts "Please press any button to continue.."
    gets
  end

  def display_hand_and_dealer_card
    clear
    puts "** #{human.name}'s cards : #{human.hand.hand_to_s} **"
    puts "** Total : #{human.hand.score} **"
    puts "** #{dealer.name}'s' card : #{dealer.hand.dealer_card} **"
  end

  def display_human_info
    puts "** #{human.name}'s cards : #{human.hand.hand_to_s} **"
    puts "** Total : #{human.hand.score} **"
  end

  def display_dealer_info
    puts "** #{dealer.name}'s cards are #{dealer.hand.hand_to_s} **"
    puts "** #{dealer.name}'s' total : #{dealer.hand.score} **"
  end

  def display_final_cards
    clear
    display_human_info
    display_dealer_info
  end

  def display_dealer_busted
    clear
    display_final_cards
    puts ''
    puts "Congratulations #{human.name}, " \
         "#{dealer.name} has busted, making you the winner!"
  end

  def display_human_busted
    clear
    display_final_cards
    puts ''
    puts "I'm sorry #{human.name}, you have busted! " \
         "#{dealer.name} is the winner!"
    puts ''
  end

  def display_blackjack
    puts "Blackjack!!"
  end

  def display_human_winner
    clear
    display_final_cards
    puts ''
    puts display_blackjack if human.blackjack?
    puts "Congratulations #{human.name}, you are the winner " \
         "with #{human.hand.score} points!"
    puts ''
  end

  def display_dealer_winner
    clear
    display_final_cards
    puts ''
    puts display_blackjack if dealer.blackjack?
    puts "I'm sorry #{human.name}, but #{dealer.name} " \
         "is the winner with #{dealer.hand.score} points! "
    puts ''
  end

  def display_tie
    clear
    display_final_cards
    puts ''
    puts display_blackjack if human.blackjack? && dealer.blackjack?
    puts "Wow we have a tie!! Each player has #{dealer.hand.score} points!"
  end

  def display_results
    if human_won?
      display_human_winner
    elsif dealer_won?
      display_dealer_winner
    else
      display_tie
    end
  end

  def display_goodbye_message
    puts "Thanks for playing!"
  end
end

class Hand
  attr_accessor :cards, :score

  include Comparable

  HIGH_SCORE = 21
  DEALER_HAULT = 17
  BLACKJACK = 21

  def initialize
    self.cards = []
  end

  def calculate_score
    self.score = 0
    cards.each do |card_obj|
      self.score += card_obj.value
    end
    cards.map(&:face).count(:ace).times do
      if self.score > HIGH_SCORE
        self.score -= 10
      end
    end
    score
  end

  def hand_to_s
    cards.map(&:to_s).join(' | ')
  end

  def dealer_card
    "#{cards[0].face} of #{cards[0].suit}"
  end

  def <=>(other_hand)
    score <=> other_hand.score
  end
end

class Player
  attr_accessor :name, :hand

  def initialize
    set_name
    self.hand = Hand.new
  end

  def busted?
    hand.score > Hand::HIGH_SCORE
  end

  def blackjack?
    hand.score == Hand::BLACKJACK
  end
end

class Human < Player
  include Displayable

  def initialize
    super
  end

  private

  def set_name
    loop do
      clear
      puts "What is your name?"
      self.name = gets.chomp.upcase
      break if name.match(/[a-z]/i)
      puts "I'm sorry, that is not valid."
      sleep(3)
    end
    clear
  end
end

class Dealer < Player
  def initialize
    super
  end

  private

  def set_name
    self.name = ['Toad', 'Mario', 'Luigi', 'Yoshi', 'Peach'].sample
  end
end

class Card
  attr_reader :suit, :face, :value

  def initialize(suit, face)
    @suit = suit
    @face = face
    @value = score
  end

  def score
    case face
    when :ace   then 11
    when :king  then 10
    when :queen then 10
    when :jack  then 10
    else face
    end
  end

  def to_s
    "#{face} of #{suit}"
  end
end

class Deck
  attr_accessor :cards

  SUITS = [:hearts, :spades, :diamonds, :clubs]
  FACES = [2, 3, 4, 5, 6, 7, 8] +
          [9, 10, :jack, :queen, :king, :ace]

  def initialize
    @cards = new_deck
  end

  def deal_card
    card = Card.new(cards.keys.sample, cards.values.flatten.sample)
    remove_card_from_deck(card)
    card
  end

  private

  def new_deck
    cards = {}
    SUITS.each do |suit|
      FACES.each do |face|
        cards.key?(suit) ? cards[suit] << face : cards[suit] = [face]
      end
    end
    cards
  end

  def remove_card_from_deck(card)
    cards[card.suit].delete(card.face)
  end
end

class Game
  include Displayable

  def initialize
    @human = Human.new
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def play
    display_welcome_message
    loop do
      mid_round_loop
      break unless play_again?
      reset
    end
    display_goodbye_message
  end

  private

  attr_reader :human, :dealer
  attr_accessor :deck

  def initial_deal
    2.times { |_| dealer.hand.cards << deck.deal_card }
    2.times { |_| human.hand.cards << deck.deal_card }
  end

  def calculate_initial_totals
    human.hand.calculate_score
    dealer.hand.calculate_score
  end

  def hit
    hand.cards << deck.deal_card
  end

  def human_decision
    answer = nil
    loop do
      puts ''
      puts "Would you like to hit or stay (h/s)?"
      answer = gets.chomp.downcase
      break if ['hit', 'h', 'stay', 's'].include?(answer)
    end
    answer
  end

  def player_hit
    puts "Here comes your next card..."
    sleep(2)
    human.hand.cards << deck.deal_card
    human.hand.calculate_score
    display_hand_and_dealer_card
  end

  def player_turn
    loop do
      choice = human_decision
      if ['hit', 'h'].include?(choice)
        player_hit
        break if human.busted? || human.blackjack?
      else
        puts "Okay, you are going to stay."
        sleep(2)
        break
      end
    end
  end

  # rubocop:disable Metrics/AbcSize
  def dealer_hit
    until dealer.hand.score >= Hand::DEALER_HAULT
      puts "#{dealer.name} is going to hit..."
      sleep(2)
      puts ''
      dealer.hand.cards << deck.deal_card
      dealer.hand.calculate_score
    end
  end
  # rubocop:enable Metrics/AbcSize

  def dealer_turn
    puts ''
    puts "#{dealer.name}'s' turn..."
    puts ''
    sleep(2)
    dealer_hit
    puts "#{dealer.name} is going to stay" if !dealer.busted?
    sleep(3)
  end

  def human_won?
    human.hand > dealer.hand
  end

  def dealer_won?
    dealer.hand > human.hand
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

  def setup_round
    initial_deal
    calculate_initial_totals
    display_hand_and_dealer_card
    player_turn unless human.blackjack?
  end

  def mid_round_loop
    loop do
      setup_round
      display_human_busted if human.busted?
      break if human.busted?

      display_hand_and_dealer_card
      dealer_turn unless dealer.blackjack?
      display_dealer_busted if dealer.busted?
      break if dealer.busted?

      end_round
      break
    end
  end

  def end_round
    clear
    display_results
  end

  def reset
    self.deck = Deck.new
    human.hand = Hand.new
    dealer.hand = Hand.new
  end
end

Game.new.play
