wally = Wally.find(1)
wally.situation_sets.order(:index).map{|ss| ss.wsituation}.each_with_index do |situation,idx|

end