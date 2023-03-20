# sum of multiples of 3 or 5 under 1000, from project euler

def sum_3_5(n)
  if n == 3
    3
  elsif n == 5
    5
  elsif n % 3 == 0 || n % 5 == 0
    n + sum_3_5(n - 1)
  else
    sum_3_5(n - 1)
  end
end

p sum_3_5(999)
