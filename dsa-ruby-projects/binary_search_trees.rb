class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array.sort.uniq)
  end

  def build_tree(array)
    return if array.empty?

    mid = array.length.div(2)
    root = Node.new(array[mid])
    root.left = build_tree(array[0...mid])
    root.right = build_tree(array[mid + 1..])
    root
  end

  def min(node)
    current = node
    # loop down to find the leftmost leaf
    current = current.left until current.left.nil?
    current
  end

  def insert(key, root = @root)
    return Node.new(key) if root.nil?

    if key > root.data
      root.right = insert(key, root.right)
    elsif key < root.data
      root.left = insert(key, root.left)
    end

    root
  end

  def delete(data, root = @root)
    return root if root.nil?

    if data < root.data
      root.left = delete(data, root.left)
    elsif data > root.data
      root.right = delete(data, root.right)
    elsif root.left.nil? && root.right.nil?
      return nil
    elsif root.right.nil?
      return root.left
    elsif root.left.nil?
      return root.right
    else
      # in order successor
      temp = min(root.right)
      root.data = temp.data
      root.right = delete(temp.data, root.right)
    end

    root
  end

  def find(data, root = @root)
    if root.nil?
      'Not found.'
    elsif root.data == data
      root
    elsif data < root.data
      find(data, root.left)
    elsif data > root.data
      find(data, root.right)
    end
  end

  def level_order(queue = [@root], arr = [])
    return if queue.empty?

    arr << queue[0].data
    queue.push(queue[0].left) unless queue[0].left.nil?
    queue.push(queue[0].right) unless queue[0].right.nil?
    queue.shift
    level_order(queue, arr)
    arr
  end

  def pre_order(root = @root, arr = [])
    return if root.nil?

    arr << root.data
    pre_order(root.left, arr)
    pre_order(root.right, arr)
    arr
  end

  def in_order(root = @root, arr = [])
    return if root.nil?

    in_order(root.left, arr)
    arr << root.data
    in_order(root.right, arr)
    arr
  end

  def post_order(root = @root, arr = [])
    return if root.nil?

    post_order(root.left, arr)
    post_order(root.right, arr)
    arr << root.data
    arr
  end

  def height(root = @root)
    return 0 if root.nil?

    left_height = height(root.left)
    right_height = height(root.right)
    left_height > right_height ? left_height + 1 : right_height + 1
  end

  def depth(data)
    height(@root) - height(find(data))
  end

  def balanced?(root = @root)
    return if root.nil?
    return false if (height(root.left) - height(root.right)).abs > 1

    balanced?(root.left)
    balanced?(root.right)
    true
  end

  def rebalance(root = @root)
    self.root = build_tree(in_order(root))
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

# driver code
e = Tree.new(Array.new(15) { rand(1..100) })
e.pretty_print
puts e.balanced?
p "Level order: #{e.level_order}"
p "Pre order: #{e.pre_order}"
p "In order: #{e.in_order}"
p "Post order: #{e.post_order}"
5.times { e.insert(rand(100..200)) }
puts e.balanced?
e.rebalance
puts e.balanced?
p "Level order: #{e.level_order}"
p "Pre order: #{e.pre_order}"
p "In order: #{e.in_order}"
p "Post order: #{e.post_order}"
