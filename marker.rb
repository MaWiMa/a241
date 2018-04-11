#!/usr/bin/env ruby
require_relative 'whatDir'
require 'rasem'
# https://github.com/aseldawy/rasem

file = A241DIR.tempdirs[2] + "/marker.svg"

img = Rasem::SVGImage.new(:width => 200, :height => 20) {
  rectangle(0,0,200,20,:stroke=>"none",:fill=>"#a1a1a1",:fill_opacity=>0.5)
}

if !File.exists?(file)
  File.open(file, "w") { |f|
    img.write(f)
  }
end
