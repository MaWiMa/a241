# look at makeAvg.rb
def cells_avg(f,c) # f file, c cell
  j,m = 0,0
  f.find_all { |r|
    i = r[:"#{c}"]
    j = j + i.to_f
    if i > 0
	  m = m + 1
    end
  }
  avg = j/m
end
