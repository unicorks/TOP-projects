# possible moves from current pos = [x+row[k], y+col[k]]

class Node
  attr_accessor :x, :y, :path
  def initialize(coords, path = [coords])
    @x = coords[0]
    @y = coords[1]
    @path = path
  end
end

def knight_moves(current_pos, desired_pos)
  row = [ 2, 2, -2, -2, 1, 1, -1, -1 ]
  col = [ -1, 1, 1, -1, 2, -2, 2, -2 ]
  queue = [Node.new(current_pos)]
  visited = []
  
  until queue.empty?
    node = queue.shift
    x = node.x
    y = node.y
    path = node.path

    if x == desired_pos[0] && y == desired_pos[1]
      puts "You made it in #{path.length-1} moves! Here's your path: "
      p path
      return
    end

    unless visited.include?(node)
      visited << node
      # add node's children to queue aka possible moves
      for i in 0...row.length
        x1 = x + row[i]
        y1 = y + col[i]
        queue << Node.new([x1, y1], path + [[x1, y1]]) unless (x1 < 0 || y1 < 0 || x1 >= 8 || y1 >= 8)
      end
    end
  end
end

knight_moves([3,3],[4,3])
