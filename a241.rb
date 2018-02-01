#!/usr/bin/ruby
# encoding: utf-8
# while read line; do $(ruby a241.rb $line);done < Data

require 'rasem'
# https://github.com/aseldawy/rasem

 klasse = ARGV[0].to_s     # 0. Klasse
   name = ARGV[1].to_s     # 1. Name des Kandidaten
   $soz = ARGV[2].to_i     # 2. Sozialkompetenz Selbsteinschätzung
   $sel = ARGV[3].to_i     # 3. Selbständigkeit Selbsteinschätzung
   $fer = ARGV[4].to_i     # 4. Fertigkeiten    Selbsteinschätzung
   $wis = ARGV[5].to_i     # 5. Wissen          Selbsteinschätzung 
   fach = ARGV[6].to_s     # 6. Fach in dem die Kompetenzen bewertet werden
  $fsoz = ARGV[7].to_i     # 7. Sozialkompetenz Bewertung durch den Prüfer im Fach
  $fsel = ARGV[8].to_i     # 8. Selbständigkeit Bewertung durch den Prüfer im Fach
  $ffer = ARGV[9].to_i     # 9. Fertigkeiten    Bewertung durch den Prüfer im Fach
  $fwis = ARGV[10].to_i    #10. Wissen          Bewertung durch den Prüfer im Fach
teacher = ARGV[11].to_s    #11. Kürzel des Prüfers  
 checks = ARGV[12].to_s    #12. Tag der Überprüfung
 height = ARGV[13].to_i    #13. scale your image (optional)

 if height == 0 # if you did not give height a default is taken
  height = 800
 end
  width = (height*1.7).to_i
# width = (height*1.11).to_i # if you only want to show the big circle

 if ARGV.length < 13
  puts "you have to write at last 13 parameter, but not more than 14"
  exit
 end

parameter = [[$soz,"Sozialkompetenz","Selbsteinschätzung"],[$sel,"Selbstständigkeit","Selbsteinschätzung"],[$fer,"Fertigkeiten","Selbsteinschätzung"],[$wis,"Wissen","Selbsteinschätzung"],[$fsoz,"Sozialkompetenz","Fremdeinschätzung"],[$fsel,"Selbstständigkeit","Fremdeinschätzung"],[$ffer,"Fertigkeiten","Fremdeinschätzung"],[$fwis,"Wissen","Fremdeinschätzung"]]

parameter.each { |i,j,k|
 case
  when i == 0
   then printf "%-18s => %-17s => %10s\n",k,j,"Keine Beurteilung"
  when i > 6
   then puts "parameter 3 to 6, 8 to 11 have to be numbers between 1 to 6"; exit
 end
 }

case $soz
   when 1 then
    a1,a2 = (height*0.55).to_i-(height*0.425*Math.sqrt(0.5)).to_i,(height*0.5).to_i-(height*0.425*Math.sqrt(0.5)).to_i
   when 2 then
    a1,a2 = (height*0.55).to_i-(height*0.35*Math.sqrt(0.5)).to_i,(height*0.5).to_i-(height*0.35*Math.sqrt(0.5)).to_i
   when 3 then
    a1,a2 = (height*0.55).to_i-(height*0.275*Math.sqrt(0.5)).to_i,(height*0.5).to_i-(height*0.275*Math.sqrt(0.5)).to_i
   when 4 then
    a1,a2 = (height*0.55).to_i-(height*0.2*Math.sqrt(0.5)).to_i,(height*0.5).to_i-(height*0.2*Math.sqrt(0.5)).to_i
   when 5 then
    a1,a2 = (height*0.55).to_i-(height*0.125*Math.sqrt(0.5)).to_i,(height*0.5).to_i-(height*0.125*Math.sqrt(0.5)).to_i
   when 6 then
    a1,a2 = (height*0.55).to_i-(height*0.05*Math.sqrt(0.5)).to_i,(height*0.5).to_i-(height*0.05*Math.sqrt(0.5)).to_i
end

case $sel
   when 1 then
    b1,b2 = (height*0.55).to_i-(height*0.425*Math.sqrt(0.5)).to_i,(height*0.5).to_i+(height*0.425*Math.sqrt(0.5)).to_i
   when 2 then
    b1,b2 = (height*0.55).to_i-(height*0.35*Math.sqrt(0.5)).to_i,(height*0.5).to_i+height*0.35*Math.sqrt(0.5)
   when 3 then
    b1,b2 = (height*0.55).to_i-(height*0.275*Math.sqrt(0.5)).to_i,(height*0.5).to_i+(height*0.275*Math.sqrt(0.5)).to_i
   when 4 then
    b1,b2 = (height*0.55).to_i-(height*0.2*Math.sqrt(0.5)).to_i,(height*0.5).to_i+(height*0.2*Math.sqrt(0.5)).to_i
   when 5 then
    b1,b2 = (height*0.55).to_i-(height*0.125*Math.sqrt(0.5)).to_i,(height*0.5).to_i+(height*0.125*Math.sqrt(0.5)).to_i
   when 6 then
    b1,b2 = (height*0.55).to_i-(height*0.05*Math.sqrt(0.5)).to_i,(height*0.5).to_i+(height*0.05*Math.sqrt(0.5)).to_i
end

case $fer
   when 1 then
    c1,c2 = (height*0.55).to_i+(height*0.425*Math.sqrt(0.5)).to_i,(height*0.5).to_i+(height*0.425*Math.sqrt(0.5)).to_i
   when 2 then
    c1,c2 = (height*0.55).to_i+(height*0.35*Math.sqrt(0.5)).to_i,(height*0.5).to_i+height*0.35*Math.sqrt(0.5)
   when 3 then
    c1,c2 = (height*0.55).to_i+(height*0.275*Math.sqrt(0.5)).to_i,(height*0.5).to_i+(height*0.275*Math.sqrt(0.5)).to_i
   when 4 then
    c1,c2 = (height*0.55).to_i+(height*0.2*Math.sqrt(0.5)).to_i,(height*0.5).to_i+(height*0.2*Math.sqrt(0.5)).to_i
   when 5 then
    c1,c2 = (height*0.55).to_i+(height*0.125*Math.sqrt(0.5)).to_i,(height*0.5).to_i+(height*0.125*Math.sqrt(0.5)).to_i
   when 6 then
    c1,c2 = (height*0.55).to_i+(height*0.05*Math.sqrt(0.5)).to_i,(height*0.5).to_i+(height*0.05*Math.sqrt(0.5)).to_i
end

case $wis
   when 1 then
    d1,d2 = (height*0.55).to_i+(height*0.425*Math.sqrt(0.5)).to_i,(height*0.5).to_i-(height*0.425*Math.sqrt(0.5)).to_i
   when 2 then
    d1,d2 = (height*0.55).to_i+(height*0.35*Math.sqrt(0.5)).to_i,(height*0.5).to_i-(height*0.35*Math.sqrt(0.5)).to_i
   when 3 then
    d1,d2 = (height*0.55).to_i+(height*0.275*Math.sqrt(0.5)).to_i,(height*0.5).to_i-(height*0.275*Math.sqrt(0.5)).to_i
   when 4 then
    d1,d2 = (height*0.55).to_i+(height*0.2*Math.sqrt(0.5)).to_i,(height*0.5).to_i-(height*0.2*Math.sqrt(0.5)).to_i
   when 5 then
    d1,d2 = (height*0.55).to_i+(height*0.125*Math.sqrt(0.5)).to_i,(height*0.5).to_i-(height*0.125*Math.sqrt(0.5)).to_i
   when 6 then
    d1,d2 = (height*0.55).to_i+(height*0.05*Math.sqrt(0.5)).to_i,(height*0.5).to_i-(height*0.05*Math.sqrt(0.5)).to_i
end

case fach
   when "m","M" then fach = "Mathematik"
   when "t","T" then fach = "Technologie" 
   when "p","P" then fach = "Politik"
   when "d","D" then fach = "Deutsch"
   when "r","R" then fach = "Religion"
   when "n","N" then fach = "Naturwissenschaft"
   else puts "Bitte nur einen Buchstaben für das Fach eingeben!"
   exit
end

case $fsoz
   when 1 then
    e1,e2 = (height*0.55).to_i-(height*0.425*Math.sqrt(0.5)).to_i,(height*0.5).to_i-(height*0.425*Math.sqrt(0.5)).to_i
   when 2 then
    e1,e2 = (height*0.55).to_i-(height*0.35*Math.sqrt(0.5)).to_i,(height*0.5).to_i-(height*0.35*Math.sqrt(0.5)).to_i
   when 3 then
    e1,e2 = (height*0.55).to_i-(height*0.275*Math.sqrt(0.5)).to_i,(height*0.5).to_i-(height*0.275*Math.sqrt(0.5)).to_i
   when 4 then
    e1,e2 = (height*0.55).to_i-(height*0.2*Math.sqrt(0.5)).to_i,(height*0.5).to_i-(height*0.2*Math.sqrt(0.5)).to_i
   when 5 then
    e1,e2 = (height*0.55).to_i-(height*0.125*Math.sqrt(0.5)).to_i,(height*0.5).to_i-(height*0.125*Math.sqrt(0.5)).to_i
   when 6 then
    e1,e2 = (height*0.55).to_i-(height*0.05*Math.sqrt(0.5)).to_i,(height*0.5).to_i-(height*0.05*Math.sqrt(0.5)).to_i
end

case $fsel
   when 1 then
    f1,f2 = (height*0.55).to_i-(height*0.425*Math.sqrt(0.5)).to_i,(height*0.5).to_i+(height*0.425*Math.sqrt(0.5)).to_i
   when 2 then
    f1,f2 = (height*0.55).to_i-(height*0.35*Math.sqrt(0.5)).to_i,(height*0.5).to_i+height*0.35*Math.sqrt(0.5)
   when 3 then
    f1,f2 = (height*0.55).to_i-(height*0.275*Math.sqrt(0.5)).to_i,(height*0.5).to_i+(height*0.275*Math.sqrt(0.5)).to_i
   when 4 then
    f1,f2 = (height*0.55).to_i-(height*0.2*Math.sqrt(0.5)).to_i,(height*0.5).to_i+(height*0.2*Math.sqrt(0.5)).to_i
   when 5 then
    f1,f2 = (height*0.55).to_i-(height*0.125*Math.sqrt(0.5)).to_i,(height*0.5).to_i+(height*0.125*Math.sqrt(0.5)).to_i
   when 6 then
    f1,f2 = (height*0.55).to_i-(height*0.05*Math.sqrt(0.5)).to_i,(height*0.5).to_i+(height*0.05*Math.sqrt(0.5)).to_i
end

case $ffer
   when 1 then
    g1,g2 = (height*0.55).to_i+(height*0.425*Math.sqrt(0.5)).to_i,(height*0.5).to_i+(height*0.425*Math.sqrt(0.5)).to_i
   when 2 then
    g1,g2 = (height*0.55).to_i+(height*0.35*Math.sqrt(0.5)).to_i,(height*0.5).to_i+height*0.35*Math.sqrt(0.5)
   when 3 then
    g1,g2 = (height*0.55).to_i+(height*0.275*Math.sqrt(0.5)).to_i,(height*0.5).to_i+(height*0.275*Math.sqrt(0.5)).to_i
   when 4 then
    g1,g2 = (height*0.55).to_i+(height*0.2*Math.sqrt(0.5)).to_i,(height*0.5).to_i+(height*0.2*Math.sqrt(0.5)).to_i
   when 5 then
    g1,g2 = (height*0.55).to_i+(height*0.125*Math.sqrt(0.5)).to_i,(height*0.5).to_i+(height*0.125*Math.sqrt(0.5)).to_i
   when 6 then
    g1,g2 = (height*0.55).to_i+(height*0.05*Math.sqrt(0.5)).to_i,(height*0.5).to_i+(height*0.05*Math.sqrt(0.5)).to_i
end

case $fwis
   when 1 then
    h1,h2 = (height*0.55).to_i+(height*0.425*Math.sqrt(0.5)).to_i,(height*0.5).to_i-(height*0.425*Math.sqrt(0.5)).to_i
   when 2 then
    h1,h2 = (height*0.55).to_i+(height*0.35*Math.sqrt(0.5)).to_i,(height*0.5).to_i-(height*0.35*Math.sqrt(0.5)).to_i
   when 3 then
    h1,h2 = (height*0.55).to_i+(height*0.275*Math.sqrt(0.5)).to_i,(height*0.5).to_i-(height*0.275*Math.sqrt(0.5)).to_i
   when 4 then
    h1,h2 = (height*0.55).to_i+(height*0.2*Math.sqrt(0.5)).to_i,(height*0.5).to_i-(height*0.2*Math.sqrt(0.5)).to_i
   when 5 then
    h1,h2 = (height*0.55).to_i+(height*0.125*Math.sqrt(0.5)).to_i,(height*0.5).to_i-(height*0.125*Math.sqrt(0.5)).to_i
   when 6 then
    h1,h2 = (height*0.55).to_i+(height*0.05*Math.sqrt(0.5)).to_i,(height*0.5).to_i-(height*0.05*Math.sqrt(0.5)).to_i
end

img = Rasem::SVGImage.new(:width => width, :height => height) do

rectangle((height*1.165).to_i,0,(height*0.535).to_i,height,:stroke=>"none",:fill=>"#e7e7e7") # background rectangle on the right side of the image
rectangle((height*1.115).to_i,0,(height*0.01).to_i,height,:stroke=>"none",:fill=>"#c9c9c9") # baseline for sharkteeth on the left

 def sharkteeth(c,h)
  polygon(
   [[0,0],[(h*0.02).to_i,(h*0.015).to_i],[0,(h*0.03).to_i]],:stroke=>"none",:fill=>c
  ) # sharktooth from left to right
 end

(1..8).each {|i| sharkteeth("#c9c9c9",height).translate((height*1.125).to_i, i*(height*0.03).to_i-(height*0.03).to_i) } # sharkteeth from left to right at X-Pos 1125 on top
(13..20).each { |i| sharkteeth("#c9c9c9",height).translate((height*1.125).to_i, i*(height*0.03).to_i-(height*0.015).to_i) } # sharkteeth from left to right at X-Pos 1125 in the middle
(1..8).each { |i| sharkteeth("#c9c9c9",height).translate((height*1.125).to_i, height-i*(height*0.03).to_i) } # sharkteeth from left to right at X-Pos 1125 at bottom
  (1..7).each { |i| sharkteeth("#e7e7e7",height).translate((height*1.165).to_i,i*(height*0.03).to_i+(height*0.015).to_i).rotate(180) } # sharkteeth from right to left at X-Pos 1165 on top
(14..20).each { |i| sharkteeth("#e7e7e7",height).translate((height*1.165).to_i,i*(height*0.03).to_i).rotate(180) } # sharkteeth from right to left at X-Pos 1165 in the middle
(1..7).each { |i| sharkteeth("#e7e7e7",height).translate((height*1.165).to_i,height-i*(height*0.03).to_i+(height*0.015).to_i).rotate(180) } # sharkteeth from right to left at X-Pos 1165 at bottom

 circlequarters = def_group("quarters") do
  def quarter(c,h)
   path(:stroke=>"none",:fill=>c) do
     moveToA((h*0.55).to_i,(h*0.5).to_i)
     hlineTo(-(h*0.448).to_i)
     arcTo((h*0.448).to_i,-(h*0.448).to_i,(h*0.448).to_i,(h*0.448).to_i,0,0,1)
     vlineTo((h*0.55).to_i)
     end
  end
  quarter("#fec72e",height).rotate(0,(height*0.55).to_i,(height*0.5).to_i) # background-quarter for social skills (Sozialkompetenz) 
  quarter("#a9a9a9",height).rotate(270,(height*0.55).to_i,(height*0.5).to_i) # background-quarter for independence (Selbstständigkeit)
  quarter("#ed7320",height).rotate(180,(height*0.55).to_i,(height*0.5).to_i) # background-quarter for skills (Fertigkeiten)
  quarter("#4d92d3",height).rotate(90,(height*0.55).to_i,(height*0.5).to_i) # background-quarter for knowledge (Wissen)
 end

use(circlequarters) # big circle in the middle
use(circlequarters,:fill_opacity=>0.5).translate((height*1.185).to_i,(height*0.1).to_i).scale(0.45,0.45) # small circle on the right top, self assessment
use(circlequarters,:fill_opacity=>0.5).translate((height*1.185).to_i,(height*0.55).to_i).scale(0.45,0.45) # small circle on the right bottom, teachers assessment 

# Label
  rectangle(0,0,(height*0.06).to_i,height,:stroke=>"none",:fill=>"#c9c9c9") # background rectangle on the left near spider diagram
  rectangle((height*0.065).to_i,0,(height*0.008).to_i,(height*0.5).to_i,:stroke=>"none",:fill=>"#fec72e") # colorbar social skills
  rectangle((height*0.065).to_i,(height*0.5).to_i,(height*0.008).to_i,height,:stroke=>"none",:fill=>"#a9a9a9") # colorbar independence
  text((height*0.05).to_i,(height*0.5).to_i,"text-anchor"=>"middle","font-family"=>"sans","font-size"=>(height*0.06).to_i,:fill=>"white"){raw "Personale Kompetenz"}.rotate(-90,(height*0.05).to_i,(height*0.5).to_i)# label soft skills 
  text((height*0.08).to_i,(height*0.07).to_i,"font-family"=>"sans","font-size"=>(height*0.04).to_i){raw "Sozialkompetenz"}
  text((height*0.08).to_i,(height*0.96).to_i,"font-family"=>"sans","font-size"=>(height*0.04).to_i){raw "Selbstständigkeit"}
  rectangle((height*1.05).to_i,0,(height*0.06).to_i,height,:stroke=>"none",:fill=>"#c9c9c9") # background rectangle on the right near spider diagram
  rectangle((height*1.037).to_i,0,(height*0.008).to_i,(height*0.5).to_i,:stroke=>"none",:fill=>"#4d92d3") # colorbar knowledge
  rectangle((height*1.037).to_i,(height*0.5).to_i,(height*0.008).to_i,height,:stroke=>"none",:fill=>"#ed7320") # colorbar skills
  text((height*1.1).to_i,(height*0.5).to_i,"text-anchor"=>"middle","font-family"=>"sans","font-size"=>(height*0.06).to_i,:fill=>"white"){raw "Fachkompetenz"}.rotate(-90,(height*1.1).to_i,(height*0.5).to_i) # label hard skills
  text((height*1.02).to_i,(height*0.96).to_i,"text-anchor"=>"end","font-family"=>"sans","font-size"=>(height*0.04).to_i){raw "Fertigkeiten"}
  text((height*1.02).to_i,(height*0.07).to_i,"text-anchor"=>"end","font-family"=>"sans","font-size"=>(height*0.04).to_i){raw "Wissen"}
# Label End
# Grid
  circle((height*0.55).to_i,(height*0.5).to_i, (height*0.05).to_i,:stroke=>"white",:stroke_width=>(height*0.004).to_i,:fill=>"none")
  circle((height*0.55).to_i,(height*0.5).to_i, (height*0.125).to_i,:stroke=>"white",:stroke_width=>(height*0.004).to_i,:fill=>"none")
  circle((height*0.55).to_i,(height*0.5).to_i, (height*0.2).to_i,:stroke=>"white",:stroke_width=>(height*0.004).to_i,:fill=>"none")
  circle((height*0.55).to_i,(height*0.5).to_i, (height*0.275).to_i,:stroke=>"white",:stroke_width=>(height*0.004).to_i,:fill=>"none")
  circle((height*0.55).to_i,(height*0.5).to_i, (height*0.35).to_i,:stroke=>"white",:stroke_width=>(height*0.004).to_i,:fill=>"none")
  circle((height*0.55).to_i,(height*0.5).to_i, (height*0.425).to_i,:stroke=>"white",:stroke_width=>(height*0.004).to_i,:fill=>"none")

 def grid_frag(h)
  line((h*0.105).to_i,(h*0.5).to_i,(h*0.52).to_i, (h*0.5).to_i, :stroke=>"white",:stroke_width=>(h*0.004).to_i)
 end
 (1..8).each { |i|
  grid_frag(height).rotate(45*i,(height*0.55).to_i,(height*0.5).to_i) }
# Grid End
# GridLabel
  lx1,ly1 = (height*0.55).to_i+(height*0.425*Math.sqrt(0.5)).to_i,(height*0.5).to_i-(height*0.425*Math.sqrt(0.5)).to_i
  lx2,ly2 = (height*0.55).to_i+(height*0.35*Math.sqrt(0.5)).to_i,(height*0.5).to_i-(height*0.35*Math.sqrt(0.5)).to_i
  lx3,ly3 = (height*0.55).to_i+(height*0.275*Math.sqrt(0.5)).to_i,(height*0.5).to_i-(height*0.275*Math.sqrt(0.5)).to_i
  lx4,ly4 = (height*0.55).to_i+(height*0.2*Math.sqrt(0.5)).to_i,(height*0.5).to_i-(height*0.2*Math.sqrt(0.5)).to_i
  lx5,ly5 = (height*0.55).to_i+(height*0.125*Math.sqrt(0.5)).to_i,(height*0.5).to_i-(height*0.125*Math.sqrt(0.5)).to_i
  lx6,ly6 = (height*0.55).to_i+(height*0.05*Math.sqrt(0.5)).to_i,(height*0.5).to_i- (height*0.05*Math.sqrt(0.5)).to_i  
  
  def gridlabel(x,y,t,h)
     circle(x,y,(h*0.02).to_i, :stroke=>"white",:stroke_width=>(h*0.004).to_i,:fill=>"gray")
     text(x,y, "dominant-baseline"=>"central","text-anchor"=>"middle","font-family"=>"sans","font-size"=>(h*0.025).to_i,:fill=>"white"){raw t}
  end

 (1..6).each { |i|
  x = binding.local_variable_get(:"lx#{i}") #  x = eval("lx#{i}")
  y = binding.local_variable_get(:"ly#{i}")
  gridlabel(x,y,i,height) }
# GridLabel End

# Notenfläche und Noteneckpunkte
  def gradepolygon(c,h,w1,w2,x1,x2,y1,y2,z1,z2,who)
   arr=[[w1,w2],[x1,x2],[y1,y2],[z1,z2]]
   # who = Selbst- oder Fremdbeurteilung
   case who
    when "s" then
     polygon(arr,:stroke=>c,:stroke_width=>(h*0.01).to_i,:fill=>c,:fill_opacity=>0.9) 
     wissen,fertigkeiten,selbststaendigkeit,sozialkompetenz = $wis,$fer,$sel,$soz
     polygon(arr,:stroke=>c,:stroke_width=>(h*0.001).to_i,:fill=>c,:fill_opacity=>0.8).translate((h*1.185).to_i,(h*0.1).to_i).scale(0.45,0.45) # this must fit to circlequarters    
    when "f" then
     polygon(arr,:stroke=>c,:stroke_width=>(h*0.01).to_i,:fill=>c,:fill_opacity=>0.6)
     wissen,fertigkeiten,selbststaendigkeit,sozialkompetenz = $fwis,$ffer,$fsel,$fsoz
     polygon(arr,:stroke=>c,:stroke_width=>(h*0.001).to_i,:fill=>c,:fill_opacity=>0.8).translate((h*1.185).to_i,(h*0.55).to_i).scale(0.45,0.45) # this must fit to circlequarters
   end
  
  arr[0][2] = sozialkompetenz
  arr[1][2] = selbststaendigkeit
  arr[2][2] = fertigkeiten
  arr[3][2] = wissen

  arr.each { |m,n,g|
     circle( m, n, (h*0.04).to_i, :stroke=>"none",:fill=>"#d9d9d9")
     circle( m, n, (h*0.036).to_i, :stroke=>"none", :fill=>c)
     circle( m, n, (h*0.028).to_i, :stroke=>"none",:fill=>"#f1f1f1")
     text( m, n, "dominant-baseline"=>"central","text-anchor"=>"middle","font-family"=>"sans","font-size"=>(h*0.04).to_i,:fill_opacity=>0.8){raw g} }
  end
 
 self_assessment = [$wis,$fer,$sel,$soz]
 teachers_assessment = [$fwis,$ffer,$fsel,$fsoz]
 if self_assessment.include?(0)
  printf "%-53s:%2s%2s%2s%2s\n",
  "At least one parameter of self assessment is null",$wis,$fer,$sel,$soz
  sges = "-"
 else 
  gradepolygon("#FFFFFF",height,a1,a2,b1,b2,c1,c2,d1,d2,"s") # self assessment
  sges = self_assessment.sum/self_assessment.length.to_f
 end

 if teachers_assessment.include?(0)
  printf "%-53s:%2s%2s%2s%2s\n",
  "At least one parameter of teachers assessment is null",$fwis,$ffer,$fsel,$fsoz
  fges = "-"
 else
  gradepolygon("#508A05",height,e1,e2,f1,f2,g1,g2,h1,h2,"f") # teachers assessment
  fges = teachers_assessment.sum/teachers_assessment.length.to_f
 end

 rectangle((height*1.24).to_i,(height*0.02).to_i,(height*0.38).to_i,(height*0.07).to_i,:stroke=>"none",:fill=>"white") # background for subject, pupil, teacher
 text((height*1.26).to_i,(height*0.05).to_i,"font-family"=>"sans","font-size"=>(height*0.024).to_i){raw fach}
 text((height*1.26).to_i,(height*0.08).to_i,"font-family"=>"sans","font-size"=>(height*0.024).to_i){raw name + ", " + teacher}
 rectangle((height*1.24).to_i,(height*0.12).to_i,(height*0.38).to_i,(height*0.05).to_i,:stroke=>"none",:fill=>"white") # background for self assessment from pupil
  text((height*1.26).to_i,(height*0.155).to_i,"font-family"=>"sans","font-size"=>(height*0.024).to_i){raw "Selbstbewertung"}
  circle((height*1.432).to_i,(height*0.325).to_i,(height*0.048).to_i, :stroke=>"none",:fill=>"white") # this must fit to circlequarters
  text((height*1.432).to_i,(height*0.325).to_i, "dominant-baseline"=>"central","text-anchor"=>"middle","font-family"=>"sans","font-size"=>(height*0.04).to_i){raw sges} # grade from self assessment, this must fit to circlequarters

 rectangle((height*1.24).to_i,(height*0.57).to_i,(height*0.38).to_i,(height*0.05).to_i,:stroke=>"none",:fill=>"white") # background for teachers assessment
  text((height*1.26).to_i,(height*0.605).to_i,"font-family"=>"sans","font-size"=>(height*0.024).to_i){raw "Fremdbewertung"}
  circle((height*1.432).to_i,(height*0.775).to_i,(height*0.048).to_i, :stroke=>"none",:fill=>"white") # this must fit to circlequarters
  text((height*1.432).to_i,(height*0.775).to_i, "dominant-baseline"=>"central","text-anchor"=>"middle","font-family"=>"sans","font-size"=>(height*0.04).to_i){raw fges} # grade from teacher, this must fit to circlequarters
# Gesamtnote End
end

File.open("a241/images/#{klasse}-#{name}-#{fach}-#{checks}.svg", "w") { |f| img.write(f) } # store svg on disk
