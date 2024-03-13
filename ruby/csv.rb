#!/usr/bin/env ruby
# frozen_string_literal: true

# run like:
# scripts/csv_loop some_file.csv '<command> $VALUE'

require 'csv'

CSV.foreach(ARGV[0]) do |row|
  exports = row.map.with_index { |value, index| "VALUE#{index}='#{value.to_s.gsub('"', '').strip}'" }
  cmd = %(export #{exports.join(' ')}; #{ARGV[1]})
  puts cmd
  system cmd
end