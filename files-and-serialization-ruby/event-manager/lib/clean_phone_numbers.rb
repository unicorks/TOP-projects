require 'csv'
require 'erb'

def clean_number(number)
  number = number.to_s.delete("^0-9")
  number.length == 10 ? number : (number[0] == "1" && number[1..-1].length == 10) ? number[1..-1] : "No number"
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  phone = clean_number(row[:homephone])
  puts "#{name}   #{phone}"
end
