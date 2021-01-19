require 'write_xlsx'

# Create a new Excel workbook
workbook = WriteXLSX.new('ruby.xlsx')

# Add a worksheet
worksheet = workbook.add_worksheet

# Add and define a format
answer1 = OpenAnswer.new()
answer1.answer_text = "Me voy de ahí"

item = Item.new

info_table = [
     %w( positivo Admisión n1 t1 faltante ),
     %W( negativo Afirmación n2 t2 =""),
     %W( neutro Cumplir ="" t3 =""),
     %W( faltante Fix ="" ="" ="")
]

data_sheet = workbook.add_worksheet
info_table.each_with_index do |row, i|
  row.each_with_index do |column_val, j|
    puts info_table[i][j]
    data_sheet.write(i,j, column_val)
  end
end

puts data_sheet.name()
workbook.define_name('main', data_sheet.name()+'!$A$1:$A$3')
workbook.define_name('positivo', data_sheet.name()+'!$B$1:$B$3')
workbook.define_name('negativo', data_sheet.name()+'!$C$1:$C$2')
workbook.define_name('neutro', data_sheet.name()+'!$D$1:$D$3')

choice1 = Choice.new choice_text: "POSITIVO", choice_value:3
choice2 = Choice.new choice_text: "NEGATIVO", choice_value:1
choice3 = Choice.new choice_text: "NEUTRO", choice_value:2
choice4 = Choice.new choice_text: "A", choice_value:1
choice5 = Choice.new choice_text: "B", choice_value:2
choice6 = Choice.new choice_text: "C", choice_value:3
choice7 = Choice.new choice_text: "D", choice_value:4
choice8 = Choice.new choice_text: "E", choice_value:5
choice9 = Choice.new choice_text: "F", choice_value:6
choice10 = Choice.new choice_text: "G", choice_value:7
choice11 = Choice.new choice_text: "H", choice_value:8
choice12 = Choice.new choice_text: "H", choice_value:9

choice1.children<<choice4
choice1.children<<choice5
choice1.children<<choice6
choice1.children<<choice7

choice2.children<<choice8
choice2.children<<choice9
choice2.children<<choice10


choice3.children<<choice11
choice3.children<<choice12

parents = [choice1, choice2, choice3]

item.choices << choice1
item.choices << choice2
item.choices << choice3
item.choices << choice4
item.choices << choice5
item.choices << choice6
item.choices << choice6

answer = OpenAnswer.new answer_text: "First answer", item: item
answer2 = OpenAnswer.new answer_text: "Second answer", item: item
answers = [answer, answer2]
(1..100).each_with_index do |number,index|
  answer_text = (0...8).map { (65 + rand(26)).chr }.join
  answers.push(OpenAnswer.new answer_text: answer_text, item: item)
end

worksheet.write('a1', 'id')
worksheet.write('b1', 'Respuesta')
worksheet.write('c1', 'Clasificacion')
worksheet.write('d1', 'Codificacion')
worksheet.write('e1', 'Codificacion')
worksheet.write('f1', 'Codificacion')
worksheet.write('g1', 'Codificacion')
worksheet.write('h1', 'Codificacion')
worksheet.write('i1', 'Codificacion')

OpenAnswer.all.each_with_index do |answer, index|
  index = index+1
  worksheet.write(index,0, answer.id)
  worksheet.write(index,1, answer.answer_text)
  #give the posibility to select the answers
  worksheet.data_validation(index, 2, {
      :validate => 'list',
      :value  => '=main'
  })

  #worksheet.write(index,2, 'positivo')

  worksheet.data_validation(index, 3, {
      :validate => 'list',
      :value  => '=INDIRECT($C$'+(index+1).to_s + ')'
  })

  worksheet.data_validation(index, 4, {
      :validate => 'list',
      :value  => '=INDIRECT($C$'+(index+1).to_s + ')'
  })

  worksheet.data_validation(index, 5, {
      :validate => 'list',
      :value  => '=INDIRECT($C$'+(index+1).to_s + ')'
  })

  worksheet.data_validation(index, 6, {
      :validate => 'list',
      :value  => '=INDIRECT($C$'+(index+1).to_s + ')'
  })

  worksheet.data_validation(index, 7, {
      :validate => 'list',
      :value  => '=INDIRECT($C$'+(index+1).to_s + ')'
  })

  worksheet.data_validation(index, 8, {
      :validate => 'list',
      :value  => '=INDIRECT($C$'+(index+1).to_s + ')'
  })
  worksheet.data_validation(index, 9, {
      :validate => 'list',
      :value  => '=INDIRECT($C$'+(index+1).to_s + ')'
  })


end

workbook.close
return

format = workbook.add_format # Add a format
format.set_bold
format.set_color('red')
format.set_align('center')

# Write a formatted and unformatted string, row and column notation.
col = row = 0
worksheet.write(row, col, "Hi Excel!", format)
worksheet.write(1,   col, "Hi Excel!")

# Write a number and a formula using A1 notation
worksheet.write('A3', 1.2345)
worksheet.write('A4', '=SIN(PI()/4)')

workbook.close
