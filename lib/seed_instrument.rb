

instruction = "Aquí hay una prueba de detectives para ver qué tan bueno eres como detective para resolver problemas. "+
    "Aquí tienes tu sombrero de detective, si quieres usarlo (usted deberá hacer la acción de entregarle un sombrero imaginario). "
+"Te mostraré algunas imágenes de escenas donde aparecen problemas. Ve si puedes resolverlos por tu cuenta. ¡Buena suerte!"
instrument = Instrument.create(name: 'Wally Original', instruction: instruction)

descriptions =["Supongamos que le pides a una amiga que juegue contigo y ella dice que no. ¿Qué harías?",
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

descriptions.each_with_index { |description, index |
  picture = nil
  begin  # "try" block
    puts 'I am before the raise.'
    picture = Picture.new(image:File.open(File.join(Rails.root,"db","seeds","wally_original","#{index+1}.jpg")))

  rescue # optionally: `rescue Exception => ex`
    picture = Picture.new(image:File.open(File.join(Rails.root,"db","seeds","wally_original","#{index+1}.png")))
    puts 'I am rescued.'
    end

  item = Item.new(description:description, order: index, picture: picture)
  instrument.items << item
   }



instrument.save