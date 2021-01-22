
this_dir =  File.dirname(__FILE__)
require 'json'

instructions = [["Aquí hay una prueba de detectives para ver qué tan bueno eres como detective para resolver problemas. ",
    "Aquí tienes tu sombrero de detective, si quieres usarlo (usted deberá hacer la acción de entregarle un sombrero imaginario). ",
"Te mostraré algunas imágenes de escenas donde aparecen problemas. Ve si puedes resolverlos por tu cuenta. ¡Buena suerte!"].join(''),
                ["Aquí hay una prueba de detectives para ver qué tan buena eres como detective para resolver problemas. ",
                 "Aquí tienes tu sombrero de detective, si quieres usarlo (usted deberá hacer la acción de entregarle un sombrero imaginario). ",
                 "Te mostraré algunas imágenes de escenas donde aparecen problemas. Ve si puedes resolverlos por tu cuenta. ¡Buena suerte!"].join('')]

instruments = []
names = ["Wally Original Hombres", "Wally Original Mujeres"]
n_instruments = 2
dirs= ['Niños', 'Niñas']
descriptions = ["Supongamos que le pides a una amiga que juegue contigo y ella dice que no. ¿Qué harías?",
               "Supongamos que rompiste el jarrón favorito de tu mamá/papá. ¿Qué harías?",
               "Supongamos que tu hermana comenzó a molestarte y tú comenzaste a molestarla a ella también, luego tu mamá/papá te manda a tu pieza . ¿Qué harías?",
               "Supongamos que otro niño en el colegio/jardín te molesta y se burla constantemente de ti. ¿Qué harías?",
               "Supongamos que realmente quieres un juguete de la tienda pero tu papá/mamá no te lo quiere comprar. ¿Qué harías?",
               "Supongamos que acabas de romper los pantalones nuevos que tu mamá/papá te compró para una situación especial. ¿Qué harías?",
               "Supongamos que otra niña te llama bebé porque juegas a las muñecas. ¿Qué harías?",
               "Supongamos que estás solo y quieres jugar con otros niños en el patio. ¿Qué harías?",
               "Supongamos que el queque que tenías guardado desapareció repentinamente y ves migas/pedazos de queque en la boca de tu hermana. ¿Qué harías?",
               "Supongamos que tu hermano destruye tu juguete armable que has estado haciendo durantes dos semana. ¿Qué harías?",
               "Supongamos que solo queda un trozo de pizza y tu hermana y tú lo quieren. ¿Qué arías?",
               "Supongamos que tu profesor está enojado contigo porque no regresaste del recreo cuando sonó el timbre. ¿Qué harías?",
               "Supongamos que un niño mucho menor que tú comienza a pegarte. ¿Qué harías?",
               "Supongamos que un niño ha estado jugando durante mucho, mucho tiempo con una bicicleta y tú quieres jugar con ella. ¿Qué harías?",
               "Supongamos que quieres conocer a un niño nuevo que acaba de llegar a la casa del vecino. ¿Qué harías?"]
desc_girls =["Supongamos que le pides a un amigo que juegue contigo y él dice que no, ¿Qué Harías?",
            "Supongamos que rompiste el jarrón favorito de tu mamá/papá. ¿Qué harías?",
            "Supongamos que tu hermana comenzó a molestarte y tú comenzaste a molestarla a ella también, luego tu mamá/papá te manda a tu pieza. ¿Qué harías?",
            "Supongamos que otra niña en el colegio/jardín te molesta y se burla constantemente de ti. ¿Qué harías?",
            "Supongamos que realmente quieres un juguete de la tienda pero tu papá/mamá no te lo quiere comprar. ¿Qué harías?",
            "Supongamos que acabas de romper los pantalones nuevos que tu mamá/papá te compró para una situación especial. ¿Qué harías?",
            "Supongamos que otro niño te llama bebé porque juegas con las muñecas. ¿Qué harías?",
            "Supongamos que estás sola y quieres jugar con otros niños en el patio. ¿Qué harías?",
            "Supongamos que el queque que tenías guardado desapareció repentinamente y ves migas/pedazos de queque en la boca de tu hermana. ¿Qué harías?",
            "Supongamos que tu hermano destruye tu juguete armable que has estado haciendo durantes dos semanas. ¿Qué harías?",
            "Supongamos que solo queda un trozo de pizza y tu hermano y tú lo quieren. ¿Qué harías?",
            "Supongamos que tu profesor está enojado contigo porque no regresaste del recreo cuando sonó el timbre. ¿Qué harías?",
            "Supongamos que un niño mucho menor que tú comienza a pegarte. ¿Qué harías?",
            "Supongamos que un niño ha estado jugando durante mucho, mucho tiempo con una bicicleta y tú quieres jugar con ella. ¿Qué harías?",
            "Supongamos que quieres conocer a un niño nuevo que acaba de llegar a la casa del vecino. ¿Qué harías?",
]
descriptions_lists = [descriptions, desc_girls]
(0.. n_instruments-1).step(1) do |idx_instrument|
  name = names[idx_instrument]
  instrument = Instrument.create(name: name, instruction: instructions[idx_instrument])
  descriptions = descriptions_lists[idx_instrument]
  descriptions.each_with_index { |description, index |
    picture = nil
    begin  # "try" block
      puts 'I am before the raise.'
      dir = dirs[idx_instrument]
      picture = Picture.new(image:File.open(File.join(Rails.root,this_dir,dir ,"#{index+1}.jpg")))
    rescue # optionally: `rescue Exception => ex`
      picture = Picture.new(image:File.open(File.join(Rails.root,this_dir,dir,"#{index+1}.png")))
      puts 'I am rescued.'
    end
    item = Item.new(description:description, order: index, picture: picture)
    instrument.items << item

  }

  instrument.save
  instruments << instrument
end


choices_texts =%w(Admisión\ /\ Decir\ la\ verdad Pedir\ disculpas Pregunta\ por\ una\ razón Pedir\ o\ exigir\ retribución )
choices_texts+=%w(Preguntar\ /\ Preguntar\ de\ nuevo\ /\ Intentar\ de\ nuevo Afirmar\ verbalmente Reclamar\ para\ si\ mismo)
choices_texts+=%W(Cumplir Retrasar Desafiar\ /\ Negar\ la\ autoridad\ adulta Mentir\ /\ Ocultar\ la\ verdad Represalias\ destructivas)
choices_texts +=%W(Diseña\ otras\ estrategias\ apropiadas Jugar Hacer\ nada Actuar\ con\ autocontrol Explicar\ /\ Dar\ una\ razón\ o\ excusa )
choices_texts +=%W(Expresar\ sentimientos\ de\ rechazo Expresar\ sentimientos\ negativos Expresar\ sentimientos\ positivos Jugar\ solo)
choices_texts +=%w(Encuentra\ una\ actividad\ alternativa Encuentra\ un\ objetivo\ alternativo Encuentra\ una\ persona\ alternativa)

choices_texts+=["Arreglar / Reparar o hacer por si mismo / Ayuda a reparar",
                "Consigue algo más",
                "Generosidad / Perdón",
                "Agarrar / Quitar Objeto",
                "Ocultar evidencia (objeto)",
                "Ignorar",
                "Dejar al azar / No asume ninguna responsabilidad",
                "Irse / Caminar / Escapar / Esconderse",
                "Moralizar / Criticar / Culpar",
                "Negociar / Negotiate",
                "Ofrecer sugerencias o ayuda","Respuesta fisica negativa para la persona", "Castigar al otro", "Castigarse a sí mismo",
                "Ser castigada por un adulto/a",
                "Rechazar verbalmente",
                "Solicitar que otro comparta",
                "Reemplazar o hacer reposición",
                "Busca ayuda de un adulto",
                "Busca ayuda de un niño/a",
                "Compartir", "Expresión verbal espontánea", "Mantenerse alejado en el futuro / Evitar", "Robar", "Burlas, Insultos, Sarcasmo",
                "Amenazar / Obligar",
                "Espera / Acepta",
                "Gritar /Pisotear",
                "Defenderse",
                "Decir por favor / Cortés",
                "Llorar / Gemir",
                "Otra respuesta / Fuera de contexto",
                "Sin respuesta / \"No lo sé\"",
                "Soborno", "Negociar / Trade", "Dar un cumplido"
]

positive_value = 1
negative_value = 2
neutral_value = 3

pos=[1, 2, 3, 5, 6, 8, 13, 16, 17, 24, 25, 27, 34 ,42, 45, 51,54,60]
neg=[7,10,11,12,15,19,21,28,29,32,36,39,48,49,50,52,55]
neu=[4,9,14,18,20,22,23,26,30,31,33,35,37,38,40,41,43,44,46,47,53,56,57,58,59]

choices = []
choices_texts.each_with_index do |text, idx|
  idx_human = idx+1
  choice_value =  if pos.include? idx_human then  positive_value elsif neg.include? idx_human then negative_value else neutral_value end
  choices << Choice.new(:choice_value=> choice_value, choice_text: text)
end

(0..n_instruments-1).each do |idx_instrument|

  instrument = instruments[idx_instrument]
  instrument.items.each do |item|
    choices.each do |choice|
      dup_choice = choice.dup
      item.choices << dup_choice
    end
    item.save
  end

  (0..10).step(1).each do |i|
    items = instrument.items
    items.each_with_index { |item, item_idx|
    }
    choices_answers = items.map{|item| [ChoiceAnswer.new(choice: item.choices[0]), ChoiceAnswer.new(choice: item.choices[1])]}.flatten
    open_answers = items.map{|item| OpenAnswer.new(answer_text:"Respuesta prueba", item: item)}
    evaluation = Evaluation.new(instrument: instrument, choice_answers: choices_answers, open_answers:open_answers)
    evaluation.save
  end
end

users_mails = ["admin.uandes@uandes.cl"]

users = User.where(email: users_mails)
study = Study.create(name:"Estudio Wally Original 2021", year:2021, users:users, instruments:instruments)
result = {study: JSON.parse(study.to_json(:include => :users)), instruments: instruments.map { |instrument| JSON.parse(instrument.to_json(:include => {:items => {:include => :choices}}))  }}

result_json = JSON.generate(result)
puts "------RESULT-------"
puts result_json