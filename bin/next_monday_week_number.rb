#!/usr/bin/env ruby

require 'date'

# Get today's date
today = Date.today

# Calculate the number of days to add to get to the next Monday
days_until_next_monday = (1 - today.wday) % 7
days_until_next_monday = 7 if days_until_next_monday.zero?

# Get next Monday's date
next_monday = today + days_until_next_monday

# Get the current week number and year
week_number = next_monday.strftime('%U').to_i + 1 # %U gives week number starting from 0
# current_year = next_monday.year

# Output the week number and year
# puts "week #{week_number - 1} of #{current_year}"
# => week 40 of 2021

puts week_number
