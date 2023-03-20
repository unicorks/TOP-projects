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

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

# driver code
e = Tree.new([1, 7, 4, 23, 8])
e.pretty_print
