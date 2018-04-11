#!/usr/bin/env ruby
# encoding: utf-8
require_relative 'whatDir'

image = A241DIR.tempdirs[2] + "/skills.svg"
file = A241DIR.statdirs[1] + "/simple.csv"

if !File.exists?(image)
  f = File.new(file, "w")
    f.write("class,name,ssoz,ssel,sfer,swis,subject,fsoz,fsel,ffer,fwis,teacher,date,height \n")
    f.write("AV01,Pan-Peter,1,3,2,4,p,2,5,4,4,REK,2018-03-01,250 \n")
  f.close
end
