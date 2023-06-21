require_relative 'chess_pieces'

def Player
    def initialise(name=get_name, color=get_color)
        @name = name
        @color = color
    end

    def get_name
        puts "Enter player name: "
        name = gets.chomp
    end

    def get_color
        while true
          puts "Enter your color, white or black: "
          color = gets.chomp
          break if downcase(color) == 'white'|| downcase(color) == 'black'
        end
        color
    end
end