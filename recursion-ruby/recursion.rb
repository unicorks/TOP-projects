def fibs(n)
    arr = [0, 1]
    for i in 2..n-1
        arr << arr[i-1] + arr[i-2]
    end
    arr
end

def fibs_rec(n)
    return [0] if n==1
    return [0, 1] if n==2
    
    arr = fibs_rec(n-1)
    return arr << arr[-1] + arr[-2]
end

p fibs_rec(8)