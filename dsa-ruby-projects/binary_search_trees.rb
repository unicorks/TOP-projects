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
        if array.empty?
            return
        end
        mid = array.length.div(2)
        root = Node.new(array[mid])
        root.left = build_tree(array[0...mid])
        root.right = build_tree(array[mid+1..-1])
        root
    end

    def insert(key, root)
        if root == nil
            return Node.new(key)
        else
            if key > root.data
                root.right = insert(key, root.right)
            elsif key < root.data
                root.left = insert(key, root.left)
            end
        end
        root
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
      end
end

# driver code
e = Tree.new([1, 7, 4, 23, 8])
e.insert(1234, e.root)
e.pretty_print