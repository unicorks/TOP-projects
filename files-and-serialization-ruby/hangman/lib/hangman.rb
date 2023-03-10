# TODO: game process, load from saved
require 'json'

class Player
  attr_accessor :guessed_letters, :guessed_word, :wrong_guesses_left, :word

  def initialise
    @guessed_letters = {}
    @word = pick_word
    @guessed_word = Array.new(@word.length, '_')
    @wrong_guesses_left = 12
  end

  private

  def pick_word
    File.open('dictionary.txt', 'r', &:readlines).filter{ |e| e.length >= 5 && e.length <= 12 }.sample
  end

  def get_letter
    # get letter from user
    while true
      letter = gets.chomp
      break if letter.count("a-zA-Z") == 1

      if letter == 'save'
        save_game
      end
    end
    letter.downcase
  end

  def check_letter(letter)
    if word.includes?(letter)
      for i in 0..word.length
        if word[i] == letter
          gw = guessed_word
          gw[i] = letter
          self.guessed_word = gw
        end
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
    puts "Correct letters guessed: #{guessed_letters.select { |_key, value| value == 'c' }}"
    puts "Incorrect letters guessed: #{guessed_letters.select { |_key, value| value == 'i' }}"
    puts guessed_word
  end

  def save_game
    dirname = 'saved'
    Dir.mkdir(dirname) unless Dir.exist?(dirname)
    while true
      puts 'Enter game name: '
      name = gets.chomp
      if File.exist?("#{dirname}/#{name}")
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
    # serialise obj state here and save to dir
    File.open("#{dirname}/#{name}.txt", 'w') { |f| f.write(json_string) }
    puts "Saved. Thankyou for playing!"
    exit
  end
end
