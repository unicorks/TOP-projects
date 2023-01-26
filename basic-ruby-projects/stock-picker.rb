# self notes- CALCULATE how much profit in each buy-sell day combo

def stock_picker(stocks)
    possible_results = {}
    stocks.each_with_index do |cost, sell_day|
        # put for loop here to calculate profit/loss with days before it and store in hash
        for i in 0..sell_day
            if stocks[i] < cost
                possible_results[cost-stocks[i]] = [i, sell_day]
            end
        end
    end
    e = possible_results.keys.max(1)[0]
    return possible_results[e]
end

p stock_picker([17,3,6,9,15,8,6,1,10])