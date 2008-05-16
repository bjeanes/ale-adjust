#!/usr/bin/env ruby
# Usage: adjust.rb file_to_convert.ale
# Adjustment values are hardcoded at the moment for a specific project. Will be variable later

require 'frametime'

ale = ARGV.shift

begin
  input = File.read(ale);

  # output = File.open(ale)
  output = $stdout

  # at the moment the frame times have to be next to each other in the ALE columns
  input.gsub!(/(\d\d:\d\d:\d\d:\d\d)\t(\d\d:\d\d:\d\d:\d\d)\t(\d\d:\d\d:\d\d:\d\d)/) do |m| 
    ft1 = FrameTime.parse($1)
    ft2 = FrameTime.parse($2)
    ft3 = FrameTime.parse($3)

    # start time has to increment a second
    ft1.add(1)
    
    # end time has to decrement one frame
    ft2.minus(0,1)
    
    # duration has to decrement one second and one frame
    ft3.minus(1,1)
    
    "#{t1.strftime("%H:%M:%S")}:#{f1}\t#{t2.strftime("%H:%M:%S")}:#{f2}\t#{t3.strftime("%H:%M:%S")}:#{f3}"
  end
  
  output.write input
rescue => e
  puts "Failure: #{e.message}"
  abort
end