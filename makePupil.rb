#!/usr/bin/env ruby
require 'csv'
require_relative 'whatDir'
require_relative 'avg'

src = A241DIR.statdirs[1] + "/data.csv"
out = A241DIR.statdirs[1] + "/avg.csv"

if ARGV[0] != out
  puts "First Parameter has to be:"
  puts out
  exit
end

pupil   = ARGV[1] # which pupils data should be parsed
subject = ARGV[2] # what subject will be shown
header  = "class,name,ssoz,ssel,sfer,swis,subject,fsoz,fsel,ffer,fwis,teacher,date,height"

k,l = 0,0

CSV.foreach(src, headers:true, header_converters: :symbol, converters: :integer) { |r|
  if r[:name] == pupil
    k = k + 1
  end
  if r[:name] == pupil && r[:subject] == subject
    l = l + 1
  end
}

if k < 1
  puts "Pupil \"#{pupil}\" does not exist!"
  exit
elsif l < 1
  puts "there is no subject \"#{subject}\" for \"#{pupil}\", maybe \"#{subject}\" does not exist!"
  exit
end

f = File.new(out, "w")
  f.write(header + "\n")
f.close

CSV.foreach(src, headers:true, header_converters: :symbol, converters: :integer) { |r|
  if r[:name] == pupil && r[:subject] == subject
    puts r
    CSV.open(out,"a") { |l|
	  l << r
    }
  end
}

puts "\n"
puts "data from \"#{src}\" sampled into \"#{out}\""

if l > 1
  new = CSV.read(out, headers:true, header_converters: :symbol, converters: :integer)
  skills = ["ssoz","ssel","sfer","swis","fsoz","fsel","ffer","fwis"]
  skills.each_with_index { |s,i|
    s = cells_avg(new,s)
    puts s
    if s.to_s == "NaN" # https://ruby-doc.org/core-2.5.0/Float.html#method-i-nan-3F
      s = 0
      puts s
    end
    skills[i] = s
  }

  print new[0][0],",",new[0][1],",",skills[0].round(1),",",skills[1].round(1),",",skills[2].round(1),",",skills[3].round(1),",",new[0][6],",",skills[4].round(1),",",skills[5].round(1),",",skills[6].round(1),",",skills[7].round(1),",",new[0][-3],",",Date.today,"\n"

  CSV.open(out,"a") { |r|
    r << [new[0][0],new[0][1],skills[0].round(1),skills[1].round(1),skills[2].round(1),skills[3].round(1),new[0][6],skills[4].round(1),skills[5].round(1),skills[6].round(1),skills[7].round(1),new[0][-3],Date.today]
  }

  puts "\n"
  puts "average assessments from \"#{out}\" attached to \"#{out}\""
end

require_relative 'makePages'
