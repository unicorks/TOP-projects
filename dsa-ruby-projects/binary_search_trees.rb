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

    def min(node)
        current = node
        # loop down to find the leftmost leaf
        current = current.left until current.left.nil?
        return current
    end

    def insert(key, root=@root)
        if root.nil?
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

    def delete(data, root=@root)
        if root.nil?
            return root
        else
            if data < root.data
                root.left = delete(data, root.left)
            elsif data > root.data
                root.right = delete(data, root.right)
            else
                if root.left.nil? && root.right.nil?
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
            end
        end
        return root
    end

    def find(data, root=@root)
        if root.nil?
            return "Not found."
        elsif root.data == data
            return root
        elsif data < root.data
            return find(data, root.left)
        elsif data > root.data
            return find(data, root.right)
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