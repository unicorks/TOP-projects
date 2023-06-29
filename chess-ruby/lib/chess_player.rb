class Player
    attr_accessor :name, :color

    @@other_color = []
    def initialize(name=get_name, color=get_color)
        @name = name
        @color = color
        @@other_color << color
    end

    def get_name
        puts "Enter player name: "
        name = gets.chomp
    end

    def get_color
        while true
          puts "Enter your color, white or black: "
          color = gets.chomp.downcase
          break if (color == 'white'|| color == 'black') && color != @@other_color[0]
        end
        color
    end
end