#!/usr/bin/ruby
# encoding: utf-8

require 'rasem'
# https://github.com/aseldawy/rasem

# go back to lastpage
img = Rasem::SVGImage.new(:width => 500, :height => 50) do

rectangle(0,0,500,50,:stroke=>"none",:fill=>"none") # background 
     text(200,40,"font-family"=>"sans","font-size"=>40,:fill=>"white"){raw "back"}
     line(30,25,170,25,:stroke=>"white",:stroke_width=>10)
     line(330,25,490,25,:stroke=>"white",:stroke_width=>10)
  
polygon([[0,25],[30,15],[30,35]],:stroke=>"none",:fill=>"white") # arrow
end

File.open("a241/images/back.svg", "w") { |f| img.write(f) } # store svg on disk

# home page 
img = Rasem::SVGImage.new(:width => 500, :height => 50) do

rectangle(0,0,500,50,:stroke=>"none",:fill=>"none") # background 
     text(200,40,"font-family"=>"sans","font-size"=>40,:fill=>"white"){raw "home"}
     line(10,25,170,25,:stroke=>"white",:stroke_width=>10)
     line(330,25,490,25,:stroke=>"white",:stroke_width=>10)
 end

File.open("a241/images/home.svg", "w") { |f| img.write(f) } # store svg on disk
# next page 
img = Rasem::SVGImage.new(:width => 500, :height => 50) do

rectangle(0,0,500,50,:stroke=>"none",:fill=>"none") # background 
     text(200,40,"font-family"=>"sans","font-size"=>40,:fill=>"white"){raw "next"}
     line(10,25,170,25,:stroke=>"white",:stroke_width=>10)
     line(330,25,470,25,:stroke=>"white",:stroke_width=>10)
  
polygon([[500,25],[470,15],[470,35]],:stroke=>"none",:fill=>"white") # arrow
end

File.open("a241/images/next.svg", "w") { |f| img.write(f) } # store svg on disk
