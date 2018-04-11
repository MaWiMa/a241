#!/usr/bin/env ruby
# encoding: utf-8
require 'asciidoctor'
require_relative 'css'
require_relative 'simple'
require_relative 'whatEnv'
require_relative 'a241'

idx = "index"

images = []
Dir.glob(A241DIR.tempdirs[2] + "/*-*.svg").each { |img|
  images.push(File.basename(img, ".svg"))
} # sample images 
images.sort! #sort images

f = File.new(A241DIR.tempdirs[3] + "/" + idx + ".txt", "w")
  f.write(":ext-relative: {outfilesuffix} \n")
  f.write(":notitle:\n")
  f.write(":nofooter:\n")
  f.write(":doctype: article \n")
  f.write(":doctitle: A241\n")
  f.write(":subject: A241\n")
  f.write(":keywords: Selbsteinschätzung, Fremdbewertung, Noten, Kompetenzbereiche, Sozialkompetenz, Selbstständigkeit, Wissen, Fertigkeiten, Ausbildungsvorbereitung, Nordrhein-Westfalen, Fachbereich Technik, Berufsfeld Bau- und Holztechnik \n")
  f.write(":copyright: CC-BY-SA 4.0 \n")
  f.write("== image:marker.svg[marker,align=\"left\"]a241 -> assessment from two fo(u)r one of them\n")
  f.write(" \n")
  f.write("image:marker.svg[marker,align=\"left\"]")
  f.write("Fachbereich Technik/Naturwissenschaften, Berufsfeld Bau- und Holztechnik \n")
  f.write(" \n")
  f.write("image:marker.svg[marker,align=\"left\"]")
  f.write("_You find the source at link:https://bitbucket.org/mawima/a241[https://bitbucket.org/mawima/a241]_\n")
  f.write(" \n")
  f.write("image:marker.svg[marker,align=\"left\",width=\"100%\",height=20px]")
  f.write(" \n")
  f.write("[coverright]#image:skills.svg[skills]# \n")
  f.write(" \n")
  f.write("[cover]#image:cover.svg[cover]# \n")
  f.write("[bottomcentersmall]#https://bitbucket.org/mawima/a241# \n")
  f.write("\n")
  if images.length < 1
    f.write("\n")
    f.write("image:marker.svg[marker,align=\"left\"]")
    f.write("Please run ruby a241.rb before you run ruby makePages.rb.\n")
    f.write("\n")
    f.write("image:marker.svg[marker,align=\"left\"]")
    f.write("The webpages will be useless without content.\n")
    f.write("\n")
    f.write("image:marker.svg[marker,align=\"left\"]")
    f.write("Take a look at the README. \n")
    f.write("\n")
    f.write("image:marker.svg[marker,align=\"left\"]")
    f.write("To delete this page, just run ruby deletePages.rb.\n")
    f.write(" \n")
  else
    m = images.length
    images.each { |img|
      f.write(" \n")
      f.write("image:marker.svg[marker,align=\"left\"]")
      f.write("link:" + img + "{ext-relative}[" + img + "]\n")
      }
    f.write(" \n")
    f.write("image:marker.svg[marker,align=\"left\"]")
    f.write(m.to_s + " records illustrated \n")
  end
f.close

Asciidoctor.render_file A241DIR.tempdirs[3] + "/" + idx + ".txt",
  :base_dir => '.',
  :to_dir => A241DIR.tempdirs[1],
  :attributes => 'linkcss stylesdir=. stylesheet=adoc.css imagesdir=images'

images.each_with_index { |img,i|
  f = File.new(A241DIR.tempdirs[3] + "/" + img + ".txt", "w")
    f.write(":ext-relative: {outfilesuffix} \n")
    f.write(":notitle:\n")
    f.write(":nofooter:\n")
    f.write(":doctype: article \n")
    f.write(":doctitle: " + img + "\n")
    f.write(":copyright: CC-BY-SA 4.0 \n")
    f.write(" \n")
    f.write("image::" + img + ".svg[" + img + ",align=\"center\",width=auto]\n")
    f.write(" \n")
    f.write("[small]#record " + (i+1).to_s + " from " + m.to_s + "#\n")
    f.write("[bottomleft]#image:back.svg[back,link=" + images[i-1] +"{ext-relative}]# \n")
    f.write("[bottomcenter]#image:home.svg[index,link=" + idx +"{ext-relative}]# \n")
    f.write("[bottomright]#image:next.svg[next,link=" + images[i+1-m] +"{ext-relative}]# \n")
  f.close

  Asciidoctor.render_file A241DIR.tempdirs[3] + "/" + img + ".txt",
    :base_dir => '.',
    :to_dir => A241DIR.tempdirs[1],
    :attributes => 'linkcss stylesdir=. stylesheet=adoc.css imagesdir=images'
}
