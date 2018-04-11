#!/usr/bin/env ruby
# encoding: utf-8
require_relative 'whatDir'

file = A241DIR.tempdirs[1] + "/adoc.css"

if !File.exists?(file)
  f = File.new(file, "w")
    f.write("html{font-family:sans-serif} \n")
    f.write("body{padding:0;margin:0} \n")
    f.write("img{max-width:100%} \n")
    f.write("h1,h2,h3,h4{text-decoration: none; position: relative; padding:0} \n")
    f.write("p{font-size: 20px;} \n")
    f.write(".cover{max-height:100%;z-index:-1; position:fixed; top:0px; left: 0px;/* opacity: 0.5*/} \n")
    f.write(".coverleft{z-index:-1; position:fixed; top:0px; left: 0px; opacity: 0.3} \n")
    f.write(".coverright{z-index:-1; position:fixed; bottom:0px; right: 0px; opacity: 0.3} \n")
    f.write(".bottomleft{position: fixed; bottom: 0em;left: 0.5%;background-color:#C7C7C7; width:33%;height:40px;opacity: 0.5; text-align:center} \n")
    f.write(".bottomcenter{position: fixed; bottom:0em; left: 33.5%; background-color:#C7C7C7; width:33%;height:40px;opacity: 0.5; text-align:center} \n")
    f.write(".bottomcentersmall{position: fixed; bottom:0em; left: 33.5%; background-color:#C7C7C7; width:33%;height:25px;opacity: 0.5; display: flex; align-items: center; justify-content: center} \n")
    f.write(".bottomright{position: fixed; bottom:0em; right: 0.5%; background-color:#C7C7C7; width:33%;height:40px;opacity: 0.5; text-align:center} \n")
    f.write(".bottomleft:hover,.bottomcenter:hover,.bottomright:hover{width:33%;background-color:black;opacity: 0.6} \n")
    f.write(".small{font-size: 12px} \n")
  f.close
end
