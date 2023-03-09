require 'csv'
require 'time'

def get_day(time)
  Date.strptime(time, "%m/%d/%Y").wday
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

busy_days = Hash.new(0)
contents.each do |row|
  day = get_day(row[:regdate])
  busy_days[day] += 1
end

p busy_days.sort_by{|key, value| value }.reverse
