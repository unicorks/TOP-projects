def bubble_sort(array)
    iterations = false
    # runs sort till even a single iteration is taking place
    while true
        # runs sort once
        for i in 0..array.size-2
            if array[i] > array[i+1]
                array.insert(i+1, array.delete_at(i))
                iterations = true
                next
            end
        end
        # logic for checking whether array is sorted
        if iterations == true
            iterations = false
            next        
        else
            break
        end
    end
    array
end

p bubble_sort([4,3,78,2,0,2])