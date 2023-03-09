# TODO: choose whether continued game or new, show hint to user, track correct + incorrect letters, serialise when user wants to save game. need hangman or player class

class Player
  attr_accessor :guessed_letters, :guessed_word, :wrong_guesses_left
  attr_reader :word

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
  end
end
