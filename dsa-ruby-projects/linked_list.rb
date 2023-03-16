class Node
    attr_accessor :value, :next_node
    def initialize(value, next_node=nil)
        @value = value
        @next_node = next_node
    end
end

class LinkedList
    attr_accessor :head, :tail
    def initialize
        @head = nil
        @tail = nil
    end

    def append(value)
        if @tail == nil && @head == nil
            self.head = Node.new(value)
        elsif @tail == nil
            self.tail = Node.new(value)
            self.head.next_node = tail
        else
            self.tail.next_node = Node.new(value)
            self.tail = self.tail.next_node
        end
    end

    def prepend(value)
        e = Node.new(value)
        e.next_node = self.head
        self.head = e
    end

    def size
        # start from head, move to next, repeat until next == nil
        e = head
        count = 0
        until e == nil
            count += 1
            e = e.next_node
        end    
        count    
    end

    def at(index)
        i = 0
        e = head
        until i == index || e == nil
            i += 1
            e = e.next_node
        end
        e
    end

    def pop
        e = self.head
        until e.next_node == nil
            self.tail = e
            e = e.next_node
        end
        self.tail.next_node = nil
    end

    def contains?(value)
        e = head
        until e == nil
            if e.value == value
                return true
            end
            e = e.next_node
        end
        false
    end

    def find(value)
        e = head
        i = 0
        until e == nil
            if e.value == value
                return i
            end
            i += 1
            e = e.next_node
        end
        nil
    end

    def to_s
        str = []
        e = head
        until e == nil
            str.append(e.value)
            e = e.next_node
        end
        str.join(" -> ")
    end

    # extra credit methods
    def insert_at(value, index)
        if index == 0
            self.prepend(value)
        end
        # make new node, let prev node point to new, new node point to node at its desired idx
        old_node = self.at(index)
        i = 0
        e = head
        until i == index - 1 || e == nil
            i += 1
            e = e.next_node
        end
        e.next_node = Node.new(value, old_node)
    end

    def remove_at(index)
        if index == 0
            self.head = head.next_node
            return
        end
        # get node at idx, make prev node point to next node of removed node
        delete_node = self.at(index)
        i = 0
        e = head
        until i == index - 1 || e == nil
            i += 1
            e = e.next_node
        end
        e.next_node = delete_node.next_node
    end
end