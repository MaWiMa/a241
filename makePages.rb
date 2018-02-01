#!/usr/bin/ruby
# encoding: utf-8
require 'asciidoctor'

idx = "index"

images = []
Dir.glob("a241/images/*-*.svg").each { |img| images.push(File.basename(img, ".svg")) } # sample images 
images.sort! #sort images

f = File.new("txt/" + idx + ".txt", "w")
 f.write(":ext-relative: {outfilesuffix} \n")
 f.write(":notitle:\n")
 f.write(":nofooter:\n")
 f.write(":doctype: article \n")
 f.write(":doctitle: A241\n")
# f.write(":author: Norbert Reschke \n")
 f.write(":subject: A241\n")
 f.write(":keywords: Selbsteinschätzung, Fremdbewertung, Noten, Kompetenzbereiche, Sozialkompetenz, Selbstständigkeit, Wissen, Fertigkeiten, Ausbildungsvorbereitung, Nordrhein-Westfalen, Fachbereich Technik, Berufsfeld Bau- und Holztechnik \n")
 f.write(":copyright: CC-BY-SA 4.0 \n")
# f.write(":email: Norbert.Reschke@gMail.com \n")
 f.write("== a241 -> assessment from two fo(u)r one of them\n")
 f.write(" \n")
 f.write("Fachbereich Technik/Naturwissenschaften, Berufsfeld Bau- und Holztechnik \n")
 f.write(" \n")
 f.write("_You find the source at link:https://bitbucket.org/mawima/a241[https://bitbucket.org/mawima/a241]_\n")
 f.write(" \n")
 f.write("image::skills.svg[skills,align=\"center\",width=800px]\n")
 f.write(" \n")
 f.write(" \n")
 f.write("[cover]#image:cover.svg[cover]# \n")
# f.write("[cover]#image:skills.svg[skills, width=400px]# \n")
 f.write "[bottomcenter]#https://bitbucket.org/mawima/a241# \n"
 f.write("\n")

 images.each { |img|
 f.write("link:" + img + "{ext-relative}[" + img + "]\n")  
 f.write(" \n") }
f.close

Asciidoctor.render_file "txt/" + idx + ".txt",
:base_dir => '.',
:to_dir => 'a241/',
:attributes => 'linkcss stylesdir=. stylesheet=adoc.css imagesdir=images'

 m = images.length
images.each_with_index { |img,i|

 f = File.new("txt/" + img + ".txt", "w")
 f.write(":ext-relative: {outfilesuffix} \n")
 f.write(":notitle:\n")
 f.write(":nofooter:\n")
 f.write(":doctype: article \n")
 f.write(":doctitle: " + img + "\n")
# f.write(":author: Norbert Reschke \n")
 f.write(":copyright: CC-BY-SA 4.0 \n")
# f.write(":email: Norbert.Reschke@gMail.com \n")
 f.write(" \n")
# f.write("++++\n")
# f.write("<meta http-equiv=\"refresh\" content=\"3; url=http://example.com/\" />\n")
# f.write("++++\n")
 f.write("image::" + img + ".svg[" + img + ",align=\"center\",width=auto]\n")
 f.write(" \n")
 f.write "[bottomleft]#image:back.svg[back to index,link=" + images[i-1] +"{ext-relative}]# \n"
 f.write "[bottomcenter]#image:home.svg[back to index,link=" + idx +"{ext-relative}]# \n"
 f.write "[bottomright]#image:next.svg[back to index,link=" + images[i+1-m] +"{ext-relative}]# \n"

f.close

Asciidoctor.render_file "txt/" + img + ".txt",
:base_dir => '.',
:to_dir => 'a241/',
:attributes => 'linkcss stylesdir=. stylesheet=adoc.css imagesdir=images' }
