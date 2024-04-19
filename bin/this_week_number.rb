require 'date'

# Get the current week number and year
# %U gives week number starting from 0
week_number = Date.today.strftime('%U').to_i + 1
formatted_week_number = '%02d' % week_number

puts formatted_week_number
