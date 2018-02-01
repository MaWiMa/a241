#!/usr/bin/ruby
Dir.glob("site/images/*-*.svg").each { |file| File.delete(file)} # delete all SVG-files in dir images with one or more "-" in filename
Dir.glob("site/*.html").each { |file| File.delete(file)} # delete all HTML-files in dir site 
Dir.glob("txt/*").each { |file| File.delete(file)} #delete all files in dir txt
