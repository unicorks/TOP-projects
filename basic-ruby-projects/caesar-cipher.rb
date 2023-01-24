def caesar_cipher(key, string)
    capital_letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    small_letters = 'abcdefghijklmnopqrstuvwxyz'
    ciphered_string = []
    string = string.split('')
    string.each do |c|
        if c.match?(/[A-Z]/) == true
            idx = capital_letters.index(c)
            cipher = idx + key
            if cipher > 26
                ciphered_string.push(capital_letters[cipher%26])
            else
                ciphered_string.push(capital_letters[cipher])
            end
        elsif c.match?(/[a-z]/) == true
            idx = small_letters.index(c)
            cipher = idx + key
            if cipher > 26
                ciphered_string.push(small_letters[cipher%26])
            else
                ciphered_string.push(small_letters[cipher])
            end
        else
            ciphered_string.push(c)
        end
    end
    return ciphered_string.join('')
end