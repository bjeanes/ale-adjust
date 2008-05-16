#!/usr/bin/env ruby

require 'time'

=begin

=end


ale = ARGV.shift

begin
  input = File.read(ale);

  # output = File.open(ale)
  output = $stdout

  input.gsub!(/(\d\d:\d\d:\d\d):(\d\d)\t(\d\d:\d\d:\d\d):(\d\d)\t(\d\d:\d\d:\d\d):(\d\d)/) do |m| 
    t1 = Time.parse($1); f1 = $2
    t2 = Time.parse($3); f2 = $4
    t3 = Time.parse($5); f3 = $6

    # start time has to increment a second
    t1 += 1
    
    # end time has to decrement one frame
    t2 -= 1 if f2.to_i.zero?
    f2 = (f2.to_i - 1) % 25
    f2 = "0#{f2}" if f2.to_s.size == 1
    
    # duration has to decrement one second and one frame
    t3 -= 1
    if f3 == '00'
      f3 = '24'
      t3 -= 1
    else
      f3 = (f3.to_i - 1).to_s
      f3 = "0#{f3}" if f3.size == 1
    end
    
    "#{t1.strftime("%H:%M:%S")}:#{f1}\t#{t2.strftime("%H:%M:%S")}:#{f2}\t#{t3.strftime("%H:%M:%S")}:#{f3}"
  end
  
  output.write input
rescue => e
  puts "Failure: #{e.message}"
  abort
end