#!/usr/bin/env ruby
require_relative 'whatDir'

A241DIR.tempdirs.each { |i|
  if !File.exists?(i)
    Dir.mkdir(i,0755)
    puts "made directory: #{i}"
  else
    puts "directory: #{i} exists, nothing to change"
  end
}

A241DIR.statdirs.each { |i|
  if !File.exists?(i)
    Dir.mkdir(i,0755)
    puts "made directory: #{i}"
  else
    puts "directory: #{i} exists, nothing to change"
  end
}
