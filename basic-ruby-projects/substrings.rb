dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
def substrings(str, dictionary)
    # for word in dictionary, search for its occurrences, and append to hash
    string = str.split(" ").join("").gsub(/[^a-zA-Z]/, '').downcase
    dictionary.reduce(Hash.new(0)) do |occurrences, word|
        if string.include?(word) == true
            occurrences[word] += string.scan(/(?=#{word})/).count
        end
        occurrences
    end
end

puts substrings("Howdy partner, sit down! How's it going?", dictionary)