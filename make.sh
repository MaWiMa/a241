#!/usr/bin/bash
# before running this script
# take a look at the README, a241.rb and makePages.rb
# if you want to clean your folders site, images and txt
# run ruby deletePages.rb

#site/images/skills.svg

if [[ ! -f a241/images/back.svg || ! -f a241/images/home.svg || ! -f a241/images/next.svg ]]; then
ruby links.rb
echo "making images for links"
fi

if [[ ! -f a241/images/cover.svg  ]]; then
ruby cover.rb
echo "making cover image for homepage"
fi

if [[ ! -f a241/images/skills.svg  ]]; then
ruby a241.rb AV01 Pan-Peter n n n n p n n n n REK 2018-01-30
mv a241/images/AV01-Pan-Peter-Politik-2018-01-30.svg site/images/skills.svg
echo "making skills image for homepage"
fi

if [[ "$1" == "AV01" || "$1" == "JS11" || "$1" == "JZ11" || "$1" == "JZ17" || "$1" == "JR11" || "$1" == "IFK11" || "$1" == "IFK12" || "$1" == "IFK13" || "$1" == "IFK14" ]]
 then
  while read line
  do $(ruby a241.rb $line)
  done < Data.$1
  ruby makePages.rb
elif [[ "$1" == "Marks" || "$1" == "marks" ]] 
 then 
  for f in Data.*
   do awk 'NF > 1 {f=$(NF-6);i=$(NF-5);j=$(NF-4);k=$(NF-3);l=$(NF-2)
                 r=(i+j+k+l)/4
                 if (f == "p") { f = "Politik    "}
                 if (f == "m") { f = "Mathematik "}
                 if (f == "t") { f = "Technologie"}
                 if (f == "d") { f = "Deutsch    "}
                 printf ("%2s] %s %s,%s,%s,%s = %2.2f %s\n",NR,f,i,j,k,l,r,$2)}'\
                 Data.${f##*.} > ${f##*.}.marks
  done
else
 echo "there must be a parameter..."
 exit
fi
