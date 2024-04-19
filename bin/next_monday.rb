#!/usr/bin/env ruby

require 'date'
require 'time'

# Function to determine if a given date is in daylight saving time in Eastern Time
def in_dst?(date)
  # New York is used as a representative city for Eastern Time
  eastern_time = Time.new(date.year, date.month, date.day, 6, 0, 0, "-05:00").localtime("-05:00")
  eastern_time.dst?
end

# Get today's date
today = Date.today

# Calculate the number of days to add to get to the next Monday
days_until_next_monday = (1 - today.wday) % 7
days_until_next_monday = 7 if days_until_next_monday.zero?

# Get next Monday's date
next_monday = today + days_until_next_monday

# Determine if next Monday is in DST
offset = in_dst?(next_monday) ? '-04:00' : '-05:00'

# Create a Time object for next Monday at 6 AM Eastern Time
next_monday_6am_et = Time.new(next_monday.year, next_monday.month, next_monday.day, 6, 0, 0, offset)

# Convert to UTC and format
next_monday_6am_utc = next_monday_6am_et.getutc.strftime('%Y%m%d%H%M%S')

puts next_monday_6am_utc
