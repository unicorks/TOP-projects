def fibs(n)
  arr = [0, 1]
  for i in 2..n - 1
    arr << arr[i - 1] + arr[i - 2]
  end
  arr
end

def fibs_rec(n)
  return [0] if n == 1
  return [0, 1] if n == 2

  arr = fibs_rec(n - 1)
  arr << arr[-1] + arr[-2]
end

p fibs_rec(8)

def sort(n)
  return n if n.length < 2

  left, right = n.each_slice((n.size / 2.0).round).to_a
  left = sort(left)
  right = sort(right)

  # merge here, compare elements of left and right arrays, return merged array
  i = j = k = 0
  arr = []
  while j < left.length && k < right.length
    if left[j] < right[k]
      arr[i] = left[j]
      i += 1
      j += 1
    elsif left[j] > right[k]
      arr[i] = right[k]
      i += 1
      k += 1
    elsif left[j] == right[k]
      arr[i] = left[j]
      arr[i + 1] = right[k]
      i += 2
      j += 1
      k += 1
    end
  end
  # check remaining items
  while j < left.length
    arr[i] = left[j]
    i += 1
    j += 1
  end
  while k < right.length
    arr[i] = right[k]
    i += 1
    k += 1
  end
  arr
end

p sort([4, 2, 3, 1, -1, 8, 17, -69])
