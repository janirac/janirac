require "byebug"
class Board
    def initialize(n)
        @grid = Array.new(n) {Array.new(n, :N)}
        @size = n * n
        @width = n
    end 

    def size
        @size
    end 

    def [](indices)
        @grid[indices[0]][indices[1]]
    end 

    def []=(position, value)
        @grid[position[0]][position[1]] = value
    end 

    def num_ships
        count = 0
        @grid.each do |subArray| 
            count += subArray.count {|ele| ele == :S } 
        end 

        count
    end 

    def attack(position)
        value_at_grid = self[position]
        if value_at_grid == :S
            self[position] = :H
            puts "you sunk my battleship!"
            return true
        else
            self[position] = :X
            return false
        end 
    end 

    def place_random_ships
       placed_ships = 0
       num_of_ships_to_place = @size/4
       random = Random.new
       while placed_ships < num_of_ships_to_place
        x = random.rand(0...@width)
        y = random.rand(0...@width) 
        temp_position = [x, y]
        if self[temp_position] == :N 
            self[temp_position] = :S
            placed_ships += 1
        end 
       end 
    end 

    def hidden_ships_grid
        hidden_grid = []
     
        @grid.each do |ele|
            hidden_sub_array = []
            ele.each do |ele2|
                if ele2 == :S 
                    hidden_sub_array << :N
                else
                    hidden_sub_array << ele2
                end 
            end 
            hidden_grid << hidden_sub_array
        end  

        hidden_grid 
    end 

    def self.print_grid(grid)
        grid.each do |row|
           puts row.join(" ")
        end 
    end 

    def cheat
        Board.print_grid(@grid)
    end 

    def print
        Board.print_grid(self.hidden_ships_grid)
    end 
end
