#!/usr/bin/ruby
# encoding: utf-8

require 'rasem'
# https://github.com/aseldawy/rasem


img = Rasem::SVGImage.new(:width => 200, :height => 1000) do

rectangle(   0,   0, 200,1000,:stroke=>"none",:fill=>"#C7C7C7") # background 
     text( 180, 800,"font-family"=>"sans","font-size"=>100,:fill=>"white"){raw "Kompetenz"}.rotate(-90,180,800) # label
end

File.open("a241/images/cover.svg", "w") { |f| img.write(f) } # store svg on disk
