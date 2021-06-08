inst= Instrument.new(name:"Aces")

instruction= "Ahora.... voy a"
item_text = "¿Como se siente él?"
choices_text = ["Enojado", "Feliz", "Triste", "Asustado"]
choices_values=[1,2,3,4]
choices_order =[1,2,3,4]

inst.items<<= Item.new(item_type_id:100, description: instruction )

Ace.find(1).acases.each_with_index do |old_aces_item, idx|
  choices_order = choices_order.shuffle(random: Random.new(112332))
  item_order = idx+1
  item =Item.new(order:item_order, description: item_text)
  img = File.open(old_aces_item.picture.image.path(:vertical))
  picture = Picture.new(image:img)
  item.picture = picture
  choices_text.each_with_index do |choice_text, idx_choice|
    value = choices_values[idx_choice]
    order = choices_order[idx_choice]
    is_correct=old_aces_item.correct_feeling == value
    item.choices << Choice.new(choice_text: choice_text, choice_value: value, order: order, is_correct: is_correct)
  end
  inst.items << item
end

puts inst.items.map{|i| (!i.picture.nil?) ? i.picture.image.path : ""}
puts "#{inst.items.map{|i| i.choices}.flatten.select{|a| a.is_correct==true}.count} alternativas correctas"
puts "#{inst.items.length} items en total"