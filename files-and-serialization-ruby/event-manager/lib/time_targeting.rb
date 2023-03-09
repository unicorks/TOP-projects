require 'csv'
require 'time'

def get_hour(time)
  Time.strptime(time, "%m/%d/%Y %k:%M").hour
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

busy_hours = Hash.new(0)
contents.each do |row|
  hour = get_hour(row[:regdate])
  busy_hours[hour] += 1
end

p busy_hours.sort_by{|key, value| value }.reverse
