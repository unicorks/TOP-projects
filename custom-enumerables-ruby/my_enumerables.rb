module Enumerable
    # Your code goes here
    def my_each_with_index
      if block_given?
        for i in 0..self.length-1
          yield(self[i], i)
        end
        self
      else
        to_enum(:my_each_with_index)
      end
    end
  
    def my_select
      if block_given?
        res = []
        for i in self
          if yield(i) == true
            res << i
          end
        end
        res
      end
    end
  
    def my_all?
      if block_given?
        for i in self
          return false if yield(i) == false
        end
        true
      end
    end
  
    def my_any?
      if block_given?
        for i in self
          return true if yield(i) == true
        end
        false
      end
    end
  
    def my_none?
      if block_given?
        for i in self
          return false if yield(i) == true
        end
        true
      end
    end
  
    def my_count
      if block_given?
        count = 0
        for i in self
          count += 1 if yield(i) == true
        end
        count
      else
        self.length
      end
    end
  
    def my_map
      mapped = []
      if block_given?
        for i in self
          mapped << yield(i)
        end
        mapped
      else
        to_enum(:my_map)
      end
    end
  
    def my_inject(initial_value)
      for i in 0..self.length-1
        if i==0
          accumulator = yield(initial_value, self[i])
        else
          accumulator = yield(accumulator, self[i])
        end
      end
      accumulator
    end
  end
  
  # You will first have to define my_each
  # on the Array class. Methods defined in
  # your enumerable module will have access
  # to this method
  class Array
    # Define my_each here
    def my_each
      if block_given?
        for i in self
          yield i
        end
        self
      else
        to_enum(:my_each)
      end
    end
  end
  