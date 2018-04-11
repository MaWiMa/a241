#!/usr/bin/env ruby
require 'csv'
require_relative 'whatDir'

out = A241DIR.statdirs[1] + "/data.csv"
header = "class,name,ssoz,ssel,sfer,swis,subject,fsoz,fsel,ffer,fwis,teacher,date,height"

f = File.new(out, "w")
  f.write(header + "\n")
f.close

Dir.glob(A241DIR.statdirs[0] + "/*.[^r,s,c,t]*").each { |i| # get files with extension, but extension must not begin with letter c or r or s
  f = File.open(i)
    while !f.eof?
      l = f.readline
      if l.include?("REK") # every line not empty has this string
        puts l
        l.gsub!(" n n n n "," 0 0 0 0 ")
        CSV.open(out,"a") { |r|
	      a = l.split(" ").map(&:to_s) #line to array
          [2,3,4,5,7,8,9,10].each { |d|
            if a[d].length != 1 # integer or n (quick,dirty and untrue)
              n = Float a[d] rescue nil
              if n == nil
                message = "Error in file " + i + "; seems to be no integer or numeric value in col " + (d+1).to_s + " of data for " + a[1] + "\n"
                message.length.times do print "~" end; print "\n"
                print message
                message.length.times do print "~" end; print "\n"
                exit
              end
            end
          }
          if a.length < 13
            message = "Error in file " + i + " not enough data in line\n"
            message.length.times do print "~" end; print "\n"
            print message
            puts l
            message.length.times do print "~" end; print "\n"
            exit
          end
          if a.length > 14
            message = "Error in file " + i + " to much data in line\n"
            message.length.times do print "~" end; print "\n"
            print message
            puts l
            message.length.times do print "~" end; print "\n"
            exit
          end
	      r << a # get one row
        }
    end
  end
}
puts "\n"
puts "data from dir \"#{A241DIR.statdirs[0]}\" sampled into \"#{out}\""
