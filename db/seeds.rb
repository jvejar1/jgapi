# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#


##Fonotest

fonotest=Fonotest.create(current:true,version:0.5)
Fgroup.create(description:"Contesta de esta forma",example:true,name:"A")
Item.create(description:"3..perro",audio:nil)
FgroupItem.create(fgroup_id:1,item_id:1,index:1)
FonotestFgroup.create(fonotest_id:fonotest.id,fgroup_id:1,index:1)

Fgroup.create(description:"Contesta de esta forma",example:true,name:"B")
audio=Audio.create(audio:File.open(File.join(Rails.root,"public","system","fonotest","b0.mp3")))
item=Item.create(description:"9..manzana",correct_sequence:"manzana..9",audio:audio)
FgroupItem.create(index:1,fgroup_id:2,item:item)
FonotestFgroup.create(fonotest_id:fonotest.id,fgroup_id:2,index:1)

fgroup=Fgroup.create(description:"xd",example:false,name:"C")
audio=Audio.create(audio:File.open(File.join(Rails.root,"public","system","fonotest","b1.mp3")))
item=Item.create(description:"zapato..6",audio:audio)
FgroupItem.create(index:3,fgroup:fgroup,item:item)

audio=Audio.create(audio:File.open(File.join(Rails.root,"public","system","fonotest","b2.mp3")))
item=Item.create(description:"5..pájaro",audio:audio)
FgroupItem.create(index:4,fgroup:fgroup,item:item)

audio=Audio.create(audio:File.open(File.join(Rails.root,"public","system","fonotest","b3.mp3")))
item=Item.create(description:"2..carne",audio:audio)
FgroupItem.create(index:5,fgroup:fgroup,item:item)

FonotestFgroup.create(fonotest_id:fonotest.id,fgroup_id:fgroup.id,index:2)







#hnfset
set=Hnfset.create(current:true,version:0.5)

#Hearts and flowers
hnf=Hnftest.create(hnf_type:0)
HnftestFigure.create(hnftest:hnf,figure:0,index:1,position:0)
HnftestFigure.create(hnftest:hnf,figure:1,index:2,position:1)
HnftestFigure.create(hnftest:hnf,figure:0,index:3,position:0)
HnftestFigure.create(hnftest:hnf,figure:1,index:4,position:1)
HnftestFigure.create(hnftest:hnf,figure:1,index:5,position:1)
HnftestFigure.create(hnftest:hnf,figure:0,index:6,position:0)
HnftestFigure.create(hnftest:hnf,figure:1,index:7,position:1)
HnftestFigure.create(hnftest:hnf,figure:0,index:8,position:0)
HnftestFigure.create(hnftest:hnf,figure:0,index:9,position:1)

HnftestFigure.create(hnftest:hnf,figure:1,index:10,position:0)
HnftestFigure.create(hnftest:hnf,figure:1,index:11,position:0)
HnftestFigure.create(hnftest:hnf,figure:0,index:12,position:1)

set.hnftests<<hnf
#Hearts

hnf=Hnftest.create(hnf_type:1)
HnftestFigure.create(hnftest:hnf,figure:0,index:1,position:1)
HnftestFigure.create(hnftest:hnf,figure:0,index:2,position:0)
HnftestFigure.create(hnftest:hnf,figure:0,index:3,position:1)
HnftestFigure.create(hnftest:hnf,figure:0,index:4,position:1)
HnftestFigure.create(hnftest:hnf,figure:0,index:5,position:0)
HnftestFigure.create(hnftest:hnf,figure:0,index:6,position:1)
HnftestFigure.create(hnftest:hnf,figure:0,index:7,position:1)
HnftestFigure.create(hnftest:hnf,figure:0,index:8,position:0)
HnftestFigure.create(hnftest:hnf,figure:0,index:9,position:1)
HnftestFigure.create(hnftest:hnf,figure:0,index:10,position:1)
HnftestFigure.create(hnftest:hnf,figure:0,index:11,position:0)
HnftestFigure.create(hnftest:hnf,figure:0,index:12,position:1)

set.hnftests<<hnf


#Flowers

hnf=Hnftest.create(hnf_type:2)
HnftestFigure.create(hnftest:hnf,figure:1,index:1,position:1)
HnftestFigure.create(hnftest:hnf,figure:1,index:2,position:0)
HnftestFigure.create(hnftest:hnf,figure:1,index:3,position:1)
HnftestFigure.create(hnftest:hnf,figure:1,index:4,position:1)
HnftestFigure.create(hnftest:hnf,figure:1,index:5,position:0)
HnftestFigure.create(hnftest:hnf,figure:1,index:6,position:1)
HnftestFigure.create(hnftest:hnf,figure:1,index:7,position:1)
HnftestFigure.create(hnftest:hnf,figure:1,index:8,position:0)
HnftestFigure.create(hnftest:hnf,figure:1,index:9,position:1)
HnftestFigure.create(hnftest:hnf,figure:1,index:10,position:1)
HnftestFigure.create(hnftest:hnf,figure:1,index:11,position:0)
HnftestFigure.create(hnftest:hnf,figure:1,index:12,position:1)

set.hnftests<<hnf

#Corsi
corsi=Corsi.create(version:1,current:true)

for i in 2..4

  cseq=Csequence.create(ordered:true)

  cseq_rev=Csequence.create(ordered:false)

  for j in 0..i
    Csquare.create(square:rand(1..10),index:j+1,csequence:cseq)
    Csquare.create(square:rand(1..10),index:j+1,csequence:cseq_rev)


  end
  CorsiCsequence.create(corsi:corsi,csequence:cseq,index:i-2)
  CorsiCsequence.create(corsi:corsi,csequence:cseq_rev,index:i-2)



end

# cseq=Csequence.create(ordered:true)
#
# for i in 1..3
#   Csquare.create(square:i,index:i,csequence:cseq)
# end
# CorsiCsequence.create(corsi:corsi,csequence:cseq,index:1)
#
#
#
# cseq=Csequence.create(ordered:false)
#
# for i in 1..5
#
#   Csquare.create(square:i,index:i,csequence:cseq)
# end
# CorsiCsequence.create(corsi:corsi,csequence:cseq,index:1)


#corsi.csequences<<Csequence.create(sequence:"1-2-3-4",ordered:false,index:7)
#corsi.csequences<<Csequence.create(sequence:"6-5-4-3-2-1",ordered:false,index:8)





#########
#ACES seed
ace=Ace.create(version:1,current:true)

for i in 1..7
  picture=Picture.create(image:File.open(File.join(Rails.root,"public","system","acases","images","original","#{i}.jpg")))
  if picture.errors.any?

    picture=Picture.create(image:File.open(File.join(Rails.root,"public","system","acases","images","original","#{i}.png")))
  end
  acase=Acase.create(description:"El/Ella se siente...?",picture:picture)


  AcaseCorrectFeeling.create(acase:acase,correct_feeling:1)
  AceAcase.create(ace:ace,acase:acase,index:i)

end


#seed for wally
enojado=Picture.create(image:File.open(File.join(Rails.root,"public","system","wally_seed","enojado.png")))
feliz=Picture.create(image:File.open(File.join(Rails.root,"public","system","wally_seed","feliz.png")))
triste=Picture.create(image:File.open(File.join(Rails.root,"public","system","wally_seed","triste.png")))
asustado=Picture.create(image:File.open(File.join(Rails.root,"public","system","wally_seed","asustado.png")))

Wfeeling.create(picture:enojado,wfeeling:3)

Wfeeling.create(picture:feliz,wfeeling:1)

Wfeeling.create(picture:triste,wfeeling:2)
Wfeeling.create(picture:asustado,wfeeling:4)

wally=Wally.create(current:true)

for i in 1..4


  ws_picture=Picture.create(image:File.open(File.join(Rails.root,"public","system","wally_seed","#{i}","situation.png")))
  ws= Wsituation.create(picture_id:ws_picture.id,description:"Juan Estaba jugando y.......")


  for j in 1..4

    wr_picture=Picture.create(image:File.open(File.join(Rails.root,"public","system","wally_seed","#{i}","#{j}.png")))
    Wreaction.create(wsituation:ws,picture_id:wr_picture.id,wreaction:j,description:"description")


  end

  SituationSet.create(wally_id:wally.id,wsituation_id:ws.id)


end

require 'csv'
csvprocessor=CSVProcessor.new()
#Schools
transicion_menor=SchoolLevel.create(name:"Transicion Menor")
c2=Commune.create(name:"Puente Alto")
jardin_ernesto_pinto=School.create(name:"Jardin Infantil Ernesto Pinto Lagarrigue",commune_id:c2.id)
#process_the students

csv=CSV.read(File.join(Rails.root,"db","seeds","ernesto_pinto.csv"),headers:true)
student_inserter=StudentInserter.new(jardin_ernesto_pinto.id,transicion_menor.id)
csvprocessor.process(csv,student_inserter,student_inserter.required_fields)

c1=Commune.create(name:"Lo Barnechea")
inst_estados_americanos=School.create(name:"Instituto Estados Americanos",commune_id:c1.id)
csv=CSV.read(File.join(Rails.root,"db","seeds","trebol.csv"),headers:true)
student_inserter=StudentInserter.new(inst_estados_americanos.id,transicion_menor.id)
csvprocessor.process(csv,student_inserter,student_inserter.required_fields)




