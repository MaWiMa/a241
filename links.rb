#!/usr/bin/env ruby
# encoding: utf-8
require_relative 'whatDir'
require 'rasem'
# https://github.com/aseldawy/rasem

# go back to lastpage
file = A241DIR.tempdirs[2] + "/back.svg"
img = Rasem::SVGImage.new(:width => 500, :height => 50) {
  rectangle(0,0,500,50,:stroke=>"none",:fill=>"none") # background 
  text(200,40,"font-family"=>"sans","font-size"=>40,:fill=>"white"){raw "back"}
  line(30,25,170,25,:stroke=>"white",:stroke_width=>10)
  line(330,25,490,25,:stroke=>"white",:stroke_width=>10)
  polygon([[0,25],[30,15],[30,35]],:stroke=>"none",:fill=>"white") # arrow
}

if !File.exists?(file)
  File.open(file, "w") { |f|
    img.write(f)
  }
end

# go to homepage
file = A241DIR.tempdirs[2] + "/home.svg"
img = Rasem::SVGImage.new(:width => 500, :height => 50) {
  rectangle(0,0,500,50,:stroke=>"none",:fill=>"none") # background 
  text(200,40,"font-family"=>"sans","font-size"=>40,:fill=>"white"){raw "home"}
  line(10,25,170,25,:stroke=>"white",:stroke_width=>10)
  line(330,25,490,25,:stroke=>"white",:stroke_width=>10)
}

if !File.exists?(file)
  File.open(file, "w") { |f|
    img.write(f)
  }
end

# go to next page
file = A241DIR.tempdirs[2] + "/next.svg"
img = Rasem::SVGImage.new(:width => 500, :height => 50) {
  rectangle(0,0,500,50,:stroke=>"none",:fill=>"none") # background 
  text(200,40,"font-family"=>"sans","font-size"=>40,:fill=>"white"){raw "next"}
  line(10,25,170,25,:stroke=>"white",:stroke_width=>10)
  line(330,25,470,25,:stroke=>"white",:stroke_width=>10)
  polygon([[500,25],[470,15],[470,35]],:stroke=>"none",:fill=>"white") # arrow
}

if !File.exists?(file)
  File.open(file, "w") { |f|
    img.write(f)
  }
end
