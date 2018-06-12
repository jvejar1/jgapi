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
Fgroup.create(description:"Diga: “Voy a decir el nombre de ciertas cosas, como animales o comidas, y algunos números. Una vez que los diga, debes decirme las palabras en el mismo orden en que yo las dije. Después, debes decirme los números en el mismo orden en que yo los dije. Vamos a comenzar con un número y una palabra. Repite primero la palabra, seguida del número”",example:true,name:"A")
Item.create(description:"3..perro",audio:nil)
FgroupItem.create(fgroup_id:1,item_id:1,index:1)
FonotestFgroup.create(fonotest_id:fonotest.id,fgroup_id:1,index:1)

Fgroup.create(description:"Diga: “Ahora vas a escuchar otras palabras y otros números. Siempre dime las palabras en el mismo orden, luego dime los números en el mismo orden. Si la tarea se te hace muy difícil, dime simplemente lo que puedas recordar”",example:true,name:"B")
audio=Audio.create(audio:File.open(File.join(Rails.root,"public","system","fonotest","b0.mp3")))
item=Item.create(description:"9..manzana",correct_sequence:"manzana..9",audio:audio)
FgroupItem.create(index:1,fgroup_id:2,item:item)
FonotestFgroup.create(fonotest_id:fonotest.id,fgroup_id:2,index:1)

fgroup=Fgroup.create(description:"xd",example:false,name:"C")
audio=Audio.create(audio:File.open(File.join(Rails.root,"db","seeds","fonotest","b1.mp3")))
item=Item.create(description:"zapato..6",audio:audio)
FgroupItem.create(index:3,fgroup:fgroup,item:item)

audio=Audio.create(audio:File.open(File.join(Rails.root,"db","seeds","fonotest","b2.mp3")))
item=Item.create(description:"5..pájaro",audio:audio)
FgroupItem.create(index:4,fgroup:fgroup,item:item)

audio=Audio.create(audio:File.open(File.join(Rails.root,"db","seeds","fonotest","b3.mp3")))
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
secuences_ord=[[2,6,7],[3,4,5],[1,2,7,8],[1,3,4,9],[1,2,5,8,10],[3,4,5,7,10],
[2,5,6,7,8,9],[1,3,4,6,7,10],[1,2,3,5,8,9,10],[1,2,4,5,]]
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
male=[1,2,5,7]
female=[3,4,6,]
distractors=[3, 6, 7, 12, 13, 15, 16, 18, 21, 26]
angry=[3,6,7,11,12,13,15,16,18,19,21,22,26]
scared=[3,5,6,7,10,12,13,15,16,18,20,21,24,26]
happy=[2,8,17,25]
sad=[1,4,9,14,23]

for i in 1..26
  picture=Picture.create(image:File.open(File.join(Rails.root,"db","seeds","acases","images","original","#{i}.jpg")))
  if picture.errors.any?
    picture=Picture.create(image:File.open(File.join(Rails.root,"db","seeds","acases","images","original","#{i}.png")))
  end
  description="se siente...?"
  if(male.include?i)
    description="Él "+description
  else
    description="Ella "+description
  end
  distractor=false
  if distractors.include?i
    distractor=false
  end

  acase=Acase.create(description:description,distractor:distractor,picture:picture)


  if angry.include?i
    AcaseCorrectFeeling.create(acase:acase,correct_feeling:Ace.ANGRY)
  end
  if scared.include?i
    AcaseCorrectFeeling.create(acase:acase,correct_feeling:Ace.SCARED)
  end
  if happy.include?i
    AcaseCorrectFeeling.create(acase:acase,correct_feeling:Ace.HAPPY)

  end
  if sad.include?i
    AcaseCorrectFeeling.create(acase:acase,correct_feeling:Ace.SAD)

  end
  AceAcase.create(ace:ace,acase:acase,index:i)

end




#seed for wally
enojado=Picture.create(image:File.open(File.join(Rails.root,"db","seeds","wally_seed","enojado.png")))
feliz=Picture.create(image:File.open(File.join(Rails.root,"db","seeds","wally_seed","feliz.png")))
triste=Picture.create(image:File.open(File.join(Rails.root,"db","seeds","wally_seed","triste.png")))
asustado=Picture.create(image:File.open(File.join(Rails.root,"db","seeds","wally_seed","asustado.png")))

Wfeeling.create(picture:enojado,wfeeling:3)

Wfeeling.create(picture:feliz,wfeeling:1)

Wfeeling.create(picture:triste,wfeeling:2)
Wfeeling.create(picture:asustado,wfeeling:4)

wally=Wally.create(current:true)

situation_name=Hash(1=>"Bloques",
                    2=>"Caja de Arena",
                    3=>"Fútbol",
                    4=>"Preguntar si quiere jugar",
                    5=>"Dibujo de perro",
                    6=>"Muñeco/a de siesta")

situation_description=Hash(1=>"María/Juan estaba construyendo una torre muy alta con bloques. Bruno lo derribó.",
                           2=>"María/Juan se está divirtiendo jugando en la caja de arena cuando Bruno le pega.",
                           3=>"María/Juan estaba pegándole a una pelota de fútbol. Llegó Bruno y le quitó la pelota.",
                           4=>"María/Juan le pidió a Bruno que jugara con él/ella. Pero Bruno dijo que no quería jugar con María/Juan. Él va a jugar con Tomás.",
                           5=>"María/Juan hizo un dibujo de un perro. Bruno lo miró y dijo: “No parece un perro. ¡Parece un monstruo feo!”, y comenzó a reírse.",
                           6=>"María/Juan trajo un/a muñeco/a a la escuela para la hora de la siesta. Bruno le dijo: “¡Eres una guagua!”")


prosocial_description=Hash(1=>"¿Pedirle a Bruno que construya otra torre contigo?",
                           2=>"Decirle que hacer eso no es algo bueno?",
                           3=>"¿Pedirle a Bruno que juegue contigo?",
                           4=>"¿Preguntar si también puedes jugar con Tomás?",
                           5=>"¿Decirle a Bruno: “No importa, a mí me gusta mi dibujo”?",
                           6=>"¿Traer un juguete para que Bruno duerma con él?")

agresiva_description=Hash(1=>"¿Pegarle a Bruno o gritarle?",
                           2=>"¿Pegarle a Bruno o gritarle?",
                           3=>"¿Quitarle la pelota de vuelta o gritarle?",
                           4=>"¿Empujar a Bruno y decirle: “tú no eres mi amigo”?",
                           5=>"¿Pegarle a Bruno o gritarle?",
                           6=>"¿Decirle a Bruno: “¡No, tú eres una guagua!” o pegarle?")
desregulada_description=Hash(1=>"¿Llorar?",
                           2=>"¿Llorar?",
                           3=>"¿Llorar?",
                           4=>"¿Llorar?",
                           5=>"¿Llorar?",
                           6=>"¿Llorar?")
evasiva_description=Hash(1=>"¿Ir a buscar otra cosa para jugar?",
                           2=>"¿Ir a buscar otra cosa para jugar?",
                           3=>"¿Ir a buscar otra cosa para jugar?",
                           4=>"¿Ir a jugar con otra persona?",
                           5=>"Dejar de dibujar y buscar otra cosa para hacer?",
                           6=>"¿Ignorar a Bruno?")
for i in 1..5

  ws_picture=Picture.create(image:File.open(File.join(Rails.root,"db","seeds","wally_seed","#{i}","situation.png")))
  ws= Wsituation.create(picture_id:ws_picture.id,description:situation_description[i])

  #open prosocial
  wr_picture=Picture.create(image:File.open(File.join(Rails.root,"db","seeds","wally_seed","#{i}","prosocial.png")))
  Wreaction.create(wsituation:ws,picture_id:wr_picture.id,wreaction:Wally.PROSOCIAL,description:prosocial_description[i])

  #open agresiva
  wr_picture=Picture.create(image:File.open(File.join(Rails.root,"db","seeds","wally_seed","#{i}","agresiva.png")))
  Wreaction.create(wsituation:ws,picture_id:wr_picture.id,wreaction:Wally.AGRESIVA,description:agresiva_description[i])

  #open desregulada
   wr_picture=Picture.create(image:File.open(File.join(Rails.root,"db","seeds","wally_seed","#{i}","desregulada.png")))
  Wreaction.create(wsituation:ws,picture_id:wr_picture.id,wreaction:Wally.DESREGULADA,description:desregulada_description[i])

  #open evasiva
  wr_picture=Picture.create(image:File.open(File.join(Rails.root,"db","seeds","wally_seed","#{i}","evasiva.png")))
  Wreaction.create(wsituation:ws,picture_id:wr_picture.id,wreaction:Wally.EVASIVA,description:evasiva_description[i])


  # for j in 1..4
  #   wr_picture=Picture.create(image:File.open(File.join(Rails.root,"public","system","wally_seed","#{i}","#{j}.png")))
  #   Wreaction.create(wsituation:ws,picture_id:wr_picture.id,wreaction:j,description:"description")
  #
  # end
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




