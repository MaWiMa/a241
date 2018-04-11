#!/usr/bin/env ruby
require 'csv'
require_relative 'whatDir'

src = A241DIR.statdirs[1] + "/data.csv"
out = A241DIR.statdirs[1] + "/class.csv"

#ARGV[0] = out

if ARGV[0] != out
  puts "First Parameter has to be:"
  puts out
  exit
end

avclass = ARGV[1] # which class data should be parsed
header = "class,name,ssoz,ssel,sfer,swis,subject,fsoz,fsel,ffer,fwis,teacher,date,height"

k = 0

CSV.foreach(src, headers:true, header_converters: :symbol, converters: :integer) { |r|
  if r[:class] == avclass
    k = k + 1
  end
}

if k < 1
  puts "Class \"#{avclass}\" does not exist!"
  exit
end

f = File.new(out, "w")
  f.write(header + "\n")
f.close

CSV.foreach(src, headers:true, header_converters: :symbol, converters: :integer) { |r|
  if r[:class] == avclass
    puts r
    CSV.open(out,"a") { |l|
	  l << r
    }
  end
}

puts "\n"
puts "data from \"#{src}\" sampled into \"#{out}\""

require_relative 'makePages'
