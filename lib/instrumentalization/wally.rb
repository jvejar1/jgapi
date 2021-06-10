begin
  ItemType.find(101)
  ItemType.find(102)
  ItemType.find(2)
rescue ActiveRecord::RecordNotFound
  puts "Error: asegurarse de que existen los tipos de item 101,102,2"
  exit(1)
end
situations_file = File.open(File.join(__dir__,'situations.txt'))
feelings_by_value={Wally.HAPPY=>"Joyeux?", Wally.SAD=>"Triste?", Wally.ANGRY=>"En colère?", Wally.ONLY_GOOD=>"Ça va?"}
data = situations_file.readlines.map(&:chomp).map{|line| line.split(";")}
items =[]
wally = Wally.find(1)
orders = [1,2,3,4]
itm1_text = "Quand cela t’arrive, comment te sens-tu?"
itm2_text = "Quand cela t’arrive, que fais-tu?"
current_itm_order = 1
instruction=  "Maintenant nous allons jouer à un jeu où je te raconte des histoires sur des enfants de ton âge. Je vais utiliser des images pour m’aider à raconter l’histoire. Tu peux utiliser les images pour me dire ce que tu penses de l’histoire."
instruction_itm = Item.new(item_type_id:101, order: current_itm_order, description: instruction, report_header_prefix_choice_value:nil)
items<< instruction_itm
current_itm_order+=1
wally.situation_sets.order(:index).map{|ss| ss.wsituation}.each_with_index do |situation,idx|
  situation_img = File.open(situation.picture.image.path(:horizontal))
  situation_picture = Picture.new(image:situation_img)
  situation_description = data[idx][0]
  situation_item = Item.new(order: current_itm_order, item_type_id:102, description:situation_description, picture: situation_picture)
  current_itm_order+=1
  items<< situation_item
  orders = orders.shuffle
  feelings = Wfeeling.all.order(wfeeling: :asc)
  itm1_choices = []
  feelings.each_with_index do |feeling, idx_feeling|
    img = File.open(feeling.picture.image.path())
    picture = Picture.new(image:img)
    feeling_value = feeling.wfeeling
    text = feelings_by_value[feeling_value]
    choice_order = orders[idx_feeling]
    itm1_choices<< Choice.new(choice_text: text, choice_value: feeling_value, picture: picture, order: choice_order)

  end

  reportable_index = idx+1
  header_prefix_itm1="wally_emotion_"
  itm1 = Item.new(order: current_itm_order, item_type_id:2, description:itm1_text, choices: itm1_choices, report_header_prefix_choice_value: header_prefix_itm1, reportable_index:reportable_index)
  current_itm_order+=1
  items<<itm1
  orders = orders.shuffle
  behaviours_text = data[idx].slice(1,5)
  itm2_choices =[]
  situation.wreactions.order(wreaction: :asc).each_with_index do |reaction, idx_reaction|
    img = File.open(reaction.picture.image.path())
    picture = Picture.new(image:img)
    choice_value = reaction.wreaction
    choice_text = behaviours_text[idx_reaction]
    choice_order = orders[idx_reaction]
    itm2_choices<< Choice.new(choice_text: choice_text, choice_value: choice_value, picture:picture, order:choice_order)
  end

  header_prefix_itm2 = "wally_behaviour_"
  items<< Item.new(order: current_itm_order, item_type_id:2, description: itm2_text, choices: itm2_choices, report_header_prefix_choice_value:header_prefix_itm2, reportable_index:reportable_index)
  current_itm_order+=1
end

puts "choices:\n",items.map{|i| i.choices}.flatten.map{|c| "valor: #{c.choice_value}. texto: #{c.choice_text}, img: #{(c.picture.nil?) ? "without img" : c.picture.image.path}" }
puts "\nItems:\n",items.map{|i| "\t#{i.get_report_header_choice_value(0)}, text: #{i.description}"}
instrument = Instrument.new(name:"Wally", items:items)
instrument.save