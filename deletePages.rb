#!/usr/bin/env ruby
require 'find'
require_relative 'whatDir'

delroot = A241DIR.tempdirs[0]

if File.exists?(delroot)
  Find.find(delroot) { |d|
    if File.file?(d)
      File.delete(d)
      puts "file: #{d} deleted"
    end
  }
else
  puts "no files found, nothing to delete"
end

=begin
A241DIR.tempdirs.reverse_each { |i|
  if File.exists?(i)
    Dir.rmdir(i)
    puts "directory: #{i} deleted"
  else
    puts "no directory #{i} found, nothing to delete"
  end
}
=end
