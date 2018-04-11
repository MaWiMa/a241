#!/usr/bin/env ruby
# encoding: utf-8
if ARGV.empty?
 
  80.times do print "~" end; print "\n"
  puts "please take a look at the README\n"
  puts "you have to give a csv file to this script"
  puts "for example " + __FILE__ + " date/simple.csv"
  puts "csv file should look like this"
  puts "class,name,ssoz,ssel,sfer,swis,subject,fsoz,fsel,ffer,fwis,teacher,date,height"
  puts "\n"
  puts "class  # Klasse der Schülerin, des Schülers\n"
  puts "name   # Name der Schülerin, des Schülers\n"
  puts "ssoz   # Sozialkompetenz Selbsteinschätzung\n"
  puts "ssel   # Selbständigkeit Selbsteinschätzung\n"
  puts "ffer   # Fertigkeiten    Selbsteinschätzung\n"
  puts "fwis   # Wissen          Selbsteinschätzung\n"
  puts "subject# Fach in dem die Kompetenzen bewertet werden\n"
  puts "fsoz   # Sozialkompetenz Bewertung durch der Lehrerin, des Lehrers im Fach\n"
  puts "fsel   # Selbständigkeit Bewertung durch der Lehrerin, des Lehrers im Fach\n"
  puts "ffer   # Fertigkeiten    Bewertung durch der Lehrerin, des Lehrers im Fach\n"
  puts "fwis   # Wissen          Bewertung durch der Lehrerin, des Lehrers im Fach\n"
  puts "teacher# Kürzel der Lehrerin, des Lehrers\n"
  puts "date   # Tag der Überprüfung\n"
  puts "height # Skalierung des Bildes (optional)\n"
  80.times do print "~" end; print "\n"
  exit
end

infile = ARGV[0]     # which csv file should be parsed

if !File.exists?(infile)
  puts infile + " does not exist!"
  exit
end

require 'csv'
require 'rasem'
# https://github.com/aseldawy/rasem
require_relative 'whatEnv'
require_relative 'makeDir'
require_relative 'cover'
require_relative 'links'
require_relative 'marker'

data = CSV.foreach(infile, headers:true, header_converters: :symbol, converters: :numeric) { |r|
  parameter = [[r[:ssoz],"Sozialkompetenz","Selbsteinschätzung"],[r[:ssel],"Selbstständigkeit","Selbsteinschätzung"],[r[:sfer],"Fertigkeiten","Selbsteinschätzung"],[r[:swis],"Wissen","Selbsteinschätzung"],[r[:fsoz],"Sozialkompetenz","Fremdeinschätzung"],[r[:fsel],"Selbstständigkeit","Fremdeinschätzung"],[r[:ffer],"Fertigkeiten","Fremdeinschätzung"],[r[:fwis],"Wissen","Fremdeinschätzung"]]
  h = 700 # default value for height

  if !defined? r[:height]
    puts "r:[height] not defined"
    height = h
  elsif r[:height].nil?
    puts "r:[height] is empty"
    height = h
  elsif r[:height] == 0
    puts "r:[height] is zero"
    height = h
  else
    height = r[:height]
  end
  puts "heigth set to #{height}"
  width = (height*1.7).to_i
# width = (height*1.11).to_i # if you only want to show the big circle

  if r.length < 13
    puts "you have to write at least 13 parameter, but not more than 14"
    exit
  end

  parameter.each { |i,j,k|
    case
      when i == 0
        printf "%-18s => %-17s => %10s\n",k,j,"Keine Beurteilung"
      when i > 6
        puts "parameter 3 to 6, 8 to 11 have to be numbers between 1 to 6"
        exit
    end
  }

# x -> positiv from left to right (x = a1), center is height*0.55
# y -> positiv from top to bottom (y = a2), center is height*0.5
# the distance between grade 1 and 2 is height*0.425*Math.sqrt(0.5) - height*0.35*Math.sqrt(0.5)
# so distance between one and another grade is the same, say a = height*0.425*Math.sqrt(0.5) - height*0.35*Math.sqrt(0.5)
# so for topleft quarter a1,a2 = center - distance, center - distance
# for bottomleft quarter a1,a2 = center - distance, center + distance
# for bottomright quarter a1,a2 = center + distance, center + distance
# for topright quarter a1,a2 = center + distance, center - distance
# next step, change r from 6 integer grades to float for showing average grade for a period as overall grade

# distance a between two (integer) grades (see above)
  a = height*Math.sqrt(0.5)*0.075

  a1,a2 = height*0.55 - height*0.5*Math.sqrt(0.5) + r[:ssoz]*a,height*0.5 - height*0.5*Math.sqrt(0.5) + r[:ssoz]*a
  b1,b2 = height*0.55 - height*0.5*Math.sqrt(0.5) + r[:ssel]*a,height*0.5 + height*0.5*Math.sqrt(0.5) - r[:ssel]*a
  c1,c2 = height*0.55 + height*0.5*Math.sqrt(0.5) - r[:sfer]*a,height*0.5 + height*0.5*Math.sqrt(0.5) - r[:sfer]*a
  d1,d2 = height*0.55 + height*0.5*Math.sqrt(0.5) - r[:swis]*a,height*0.5 - height*0.5*Math.sqrt(0.5) + r[:swis]*a
  e1,e2 = height*0.55 - height*0.5*Math.sqrt(0.5) + r[:fsoz]*a,height*0.5 - height*0.5*Math.sqrt(0.5) + r[:fsoz]*a
  f1,f2 = height*0.55 - height*0.5*Math.sqrt(0.5) + r[:fsel]*a,height*0.5 + height*0.5*Math.sqrt(0.5) - r[:fsel]*a
  g1,g2 = height*0.55 + height*0.5*Math.sqrt(0.5) - r[:ffer]*a,height*0.5 + height*0.5*Math.sqrt(0.5) - r[:ffer]*a
  h1,h2 = height*0.55 + height*0.5*Math.sqrt(0.5) - r[:fwis]*a,height*0.5 - height*0.5*Math.sqrt(0.5) + r[:fwis]*a

  case r[:subject]
    when "m","M"
      subject = "Mathematik"
    when "t","T"
      subject = "Technologie"
    when "p","P"
      subject = "Politik"
    when "d","D"
      subject = "Deutsch"
    when "r","R"
      subject = "Religion"
    when "n","N"
      subject = "Naturwissenschaft"
    else puts "Bitte nur einen Buchstaben für das Fach eingeben!"
      exit
  end

  img = Rasem::SVGImage.new(:width => width, :height => height) do
    rectangle((height*1.165).to_i,0,(height*0.535).to_i,height,:stroke=>"none",:fill=>"#e7e7e7") # background rectangle on the right side of the image
    rectangle((height*1.115).to_i,0,(height*0.01).to_i,height,:stroke=>"none",:fill=>"#c9c9c9") # baseline for sharkteeth on the left

    def sharkteeth(c,h)
      polygon([[0,0],[(h*0.02).to_i,(h*0.015).to_i],[0,(h*0.03).to_i]],:stroke=>"none",:fill=>c) # sharktooth from left to right
    end

    (1..8).each { |i|
      sharkteeth("#c9c9c9",height).translate((height*1.125).to_i,i*(height*0.03).to_i-(height*0.03).to_i)
    } # sharkteeth from left to right at X-Pos 1125 on top
    (13..20).each { |i|
      sharkteeth("#c9c9c9",height).translate((height*1.125).to_i, i*(height*0.03).to_i-(height*0.015).to_i)
    } # sharkteeth from left to right at X-Pos 1125 in the middle
    (1..8).each { |i|
      sharkteeth("#c9c9c9",height).translate((height*1.125).to_i, height-i*(height*0.03).to_i)
    } # sharkteeth from left to right at X-Pos 1125 at bottom
    (1..7).each { |i|
      sharkteeth("#e7e7e7",height).translate((height*1.165).to_i,i*(height*0.03).to_i+(height*0.015).to_i).rotate(180)
    } # sharkteeth from right to left at X-Pos 1165 on top
    (14..20).each { |i|
      sharkteeth("#e7e7e7",height).translate((height*1.165).to_i,i*(height*0.03).to_i).rotate(180)
    } # sharkteeth from right to left at X-Pos 1165 in the middle
    (1..7).each { |i|
      sharkteeth("#e7e7e7",height).translate((height*1.165).to_i,height-i*(height*0.03).to_i+(height*0.015).to_i).rotate(180)
    } # sharkteeth from right to left at X-Pos 1165 at bottom

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
      grid_frag(height).rotate(45*i,(height*0.55).to_i,(height*0.5).to_i)
    }
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
      gridlabel(x,y,i,height)
    }
  # GridLabel End

  # Notenfläche und Noteneckpunkte
    def gradepolygon(c,h,w1,w2,x1,x2,y1,y2,z1,z2,who,soz,sel,fer,wis)
      arr=[[w1,w2],[x1,x2],[y1,y2],[z1,z2]]
        case who # who = Selbst- oder Fremdbeurteilung
          when "s"
            polygon(arr,:stroke=>c,:stroke_width=>(h*0.01).to_i,:fill=>c,:fill_opacity=>0.9)
            sozialkompetenz,selbststaendigkeit,fertigkeiten,wissen = soz,sel,fer,wis
            polygon(arr,:stroke=>c,:stroke_width=>(h*0.001).to_i,:fill=>c,:fill_opacity=>0.8).translate((h*1.185).to_i,(h*0.1).to_i).scale(0.45,0.45) # this must fit to circlequarters
          when "f"
            polygon(arr,:stroke=>c,:stroke_width=>(h*0.01).to_i,:fill=>c,:fill_opacity=>0.6)
            sozialkompetenz,selbststaendigkeit,fertigkeiten,wissen = soz,sel,fer,wis
            polygon(arr,:stroke=>c,:stroke_width=>(h*0.001).to_i,:fill=>c,:fill_opacity=>0.8).translate((h*1.185).to_i,(h*0.55).to_i).scale(0.45,0.45) # this must fit to circlequarters
          end
  
    arr[0][2] = sozialkompetenz
    arr[1][2] = selbststaendigkeit
    arr[2][2] = fertigkeiten
    arr[3][2] = wissen

    arr.each { |m,n,g|
      circle( m, n, (h*0.05).to_i, :stroke=>"none",:fill=>"#d9d9d9")
      circle( m, n, (h*0.046).to_i, :stroke=>"none", :fill=>c)
      circle( m, n, (h*0.038).to_i, :stroke=>"none",:fill=>"#f1f1f1")
      text( m, n, "dominant-baseline"=>"central","text-anchor"=>"middle","font-family"=>"sans","font-size"=>(h*0.04).to_i,:fill_opacity=>0.8){raw g} }
    end
 
    self_assessment = [r[:ssoz],r[:ssel],r[:sfer],r[:swis]]#[$wis,$fer,$sel,$soz]
    teachers_assessment = [r[:fsoz],r[:fsel],r[:ffer],r[:fwis]]#[$fwis,$ffer,$fsel,$fsoz]
    if self_assessment.include?(0)
      printf "%-53s:%2s%2s%2s%2s\n",
     "At least one parameter of self assessment is null", r[:ssoz],r[:ssel],r[:sfer],r[:swis]#$wis,$fer,$sel,$soz
      sges = "-"
    else
      gradepolygon("#FFFFFF",height,a1,a2,b1,b2,c1,c2,d1,d2,"s",r[:ssoz],r[:ssel],r[:sfer],r[:swis]) # self assessment
      sges = (self_assessment.sum/self_assessment.length.to_f).round(2)
    end

    if teachers_assessment.include?(0)
      printf "%-53s:%2s%2s%2s%2s\n",
      "At least one parameter of teachers assessment is null",r[:fsoz],r[:fsel],r[:ffer],r[:fwis]#$fwis,$ffer,$fsel,$fsoz
      fges = "-"
    else
      gradepolygon("#508A05",height,e1,e2,f1,f2,g1,g2,h1,h2,"f",r[:fsoz],r[:fsel],r[:ffer],r[:fwis]) # teachers assessment
      fges = (teachers_assessment.sum/teachers_assessment.length.to_f).round(2)
    end

    rectangle((height*1.24).to_i,(height*0.02).to_i,(height*0.38).to_i,(height*0.07).to_i,:stroke=>"none",:fill=>"white") # background for subject, pupil, teacher
    text((height*1.26).to_i,(height*0.05).to_i,"font-family"=>"sans","font-size"=>(height*0.024).to_i){raw r[:teacher] + ", " + subject + ", " + r[:date]}
    text((height*1.26).to_i,(height*0.08).to_i,"font-family"=>"sans","font-size"=>(height*0.024).to_i){raw r[:name]}
    rectangle((height*1.24).to_i,(height*0.12).to_i,(height*0.38).to_i,(height*0.05).to_i,:stroke=>"none",:fill=>"white") # background for self assessment from pupil
    text((height*1.26).to_i,(height*0.155).to_i,"font-family"=>"sans","font-size"=>(height*0.024).to_i){raw "Selbstbewertung"}
    circle((height*1.432).to_i,(height*0.325).to_i,(height*0.048).to_i, :stroke=>"none",:fill=>"white") # this must fit to circlequarters
    text((height*1.432).to_i,(height*0.325).to_i, "dominant-baseline"=>"central","text-anchor"=>"middle","font-family"=>"sans","font-size"=>(height*0.04).to_i){raw sges} # grade from self assessment, this must fit to circlequarters
    rectangle((height*1.24).to_i,(height*0.57).to_i,(height*0.38).to_i,(height*0.05).to_i,:stroke=>"none",:fill=>"white") # background for teachers assessment
    text((height*1.26).to_i,(height*0.605).to_i,"font-family"=>"sans","font-size"=>(height*0.024).to_i){raw "Fremdbewertung"}
    circle((height*1.432).to_i,(height*0.775).to_i,(height*0.048).to_i, :stroke=>"none",:fill=>"white") # this must fit to circlequarters
    text((height*1.432).to_i,(height*0.775).to_i, "dominant-baseline"=>"central","text-anchor"=>"middle","font-family"=>"sans","font-size"=>(height*0.04).to_i){raw fges} # grade from teacher, this must fit to circlequarters
  end

  name = r[:name].downcase.gsub(/[äöü]/) {|u|
    case u
      when "ä"
        "ae"
      when "ö"
        "oe"
      when "ü"
        "ue"
    end
  }.split(/\-/).map(&:capitalize).join() # links don't work if umlauts (Umlaute) used in filenames

  if infile != A241DIR.statdirs[1] + "/simple.csv"
    File.open(A241DIR.tempdirs[2] + "/#{r[:class]}-#{name}-#{subject}-#{r[:date]}.svg", "w") { |f|
      img.write(f)
    }
  elsif infile == A241DIR.statdirs[1] + "/simple.csv"
    File.open(A241DIR.tempdirs[2] + "/skills.svg", "w") { |f|
      img.write(f)
    }
  end
}
