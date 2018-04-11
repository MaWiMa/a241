#!/usr/bin/env ruby
# encoding: utf-8
require_relative 'whatDir'
require 'rasem'
# https://github.com/aseldawy/rasem

file = A241DIR.tempdirs[2] + "/cover.svg"

img = Rasem::SVGImage.new(:width => 200, :height => 800) {
  rectangle(0,0,200,800,:stroke=>"none",:fill=>"#C7C7C7") # background 
  text(180,600,"font-family"=>"sans","font-size"=>100,:fill=>"white"){raw "Kompetenz"}.rotate(-90,180,600) # label
}

if !File.exists?(file)
  File.open(file, "w") { |f|
    img.write(f)
  }
end
