require 'json'

class Player
  attr_accessor :guessed_letters, :guessed_word, :wrong_guesses_left, :word

  def initialize(gl, word, wg)
    @guessed_letters = gl
    @word = word
    @guessed_word = Array.new(@word.length, '_')
    @wrong_guesses_left = wg
  end

  def self.load_game
    dirname = 'saved'
    while true
      puts 'Enter game name: '
      name = gets.chomp
      break if File.exist?("#{dirname}/#{name}.json")
    end
    data = JSON.parse(File.open("#{dirname}/#{name}.json", 'r', &:read))
    File.delete("#{dirname}/#{name}.json")
    p = new(data['guessed_letters'], data['word'], data['wrong_guesses_left'])
    p.guessed_word = data['guessed_word']
    p
  end

  def start_game
    while wrong_guesses_left.positive?
      print_game_state
      letter = get_letter
      check_letter(letter)

      if word == guessed_word.join
        puts 'You won! Congrats.'
        exit
      end
    end
    puts "You lost. The word was #{word}."
  end

  def self.pick_word
    File.open('dictionary.txt', 'r', &:readlines).filter { |e| e.length >= 5 && e.length <= 12 }.sample.delete("\n")
  end

  private

  def get_letter
    # get letter from user
    while true
      puts "Enter a letter, or 'save' if you wish to save the game and exit"
      letter = gets.chomp
      break if letter.count('a-zA-Z') == 1

      save_game if letter == 'save'
    end
    letter.downcase
  end

  def check_letter(letter)
    if word.include?(letter)
      for i in 0..word.length
        next unless word[i] == letter

        gw = guessed_word
        gw[i] = letter
        self.guessed_word = gw
      end
      puts 'Correct guess!'
      gl = guessed_letters
      gl[letter] = 'c'
      self.guessed_letters = gl
    else
      puts 'Incorrect guess.'
      gl = guessed_letters
      gl[letter] = 'i'
      self.guessed_letters = gl
      wg = wrong_guesses_left
      self.wrong_guesses_left = wg - 1
    end
  end

  def print_game_state
    puts "Incorrect guesses left: #{wrong_guesses_left}"
    puts "Correct letters guessed: #{guessed_letters.select { |_key, value| value == 'c' }.keys.join(' ')}"
    puts "Incorrect letters guessed: #{guessed_letters.select { |_key, value| value == 'i' }.keys.join(' ')}"
    puts guessed_word.join('')
  end

  def save_game
    # serialise obj state here and save to dir
    dirname = 'saved'
    Dir.mkdir(dirname) unless Dir.exist?(dirname)
    while true
      puts 'Enter game name: '
      name = gets.chomp
      if File.exist?("#{dirname}/#{name}.json")
        puts 'Game already exists.'
        next
      else
        break
      end
    end
    json_string = JSON.dump({
                              guessed_letters: guessed_letters,
                              guessed_word: guessed_word,
                              wrong_guesses_left: wrong_guesses_left,
                              word: word
                            })
    File.open("#{dirname}/#{name}.json", 'w') { |f| f.write(json_string) }
    puts 'Saved. Thankyou for playing!'
    exit
  end
end

# begin game process
puts "Welcome to Hangman! Enter 0 if you'd like to begin a new game, or 1 if you'd like to load a saved game."
choice = gets.chomp.to_i
case choice
when 0
  p = Player.new({}, Player.pick_word, 12)
  p.start_game
when 1
  p = Player.load_game
  p.start_game
else
  puts "Looks like you don't want to play :("
end
