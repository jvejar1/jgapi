require 'write_xlsx'
#require 'write_xlsx/utility'
include Writexlsx::Utility

instrument_id = ""
instrument = Instrument.where(name:"Wally Original").last
choices = instrument.items[0].choices
positive_value=1
negative_value = 2
neutral_value = 3

filepath = 'ruby.xlsx'
instruments_ids =
# Create a new Excel workbook
workbook = WriteXLSX.new(filepath)
# Add a worksheet
worksheet = workbook.add_worksheet
# Add and define a format

%w(positivo negativo neutro).each_with_index do |main,idx|
  worksheet.write(idx,0, main)
end

positive_choices = choices.select{|choice | choice.choice_value==positive_value}
positive_len = positive_choices.count
positive_choices.each_with_index do |positive_choice, idx|
  worksheet.write(idx,1,positive_choice.choice_text )
end

negative_choices = choices.select{|choice| choice.choice_value == negative_value}
negative_len = negative_choices.count
negative_choices.each_with_index do |choice, idx|
  worksheet.write(idx,2, choice.choice_text)
end

neutral_choices = choices.select{|choice| choice.choice_value==neutral_value}
neutral_len = neutral_choices.count
neutral_choices.each_with_index do |choice, idx|
  worksheet.write(idx,3, choice.choice_text)
end

# Add and define a format

workbook.define_name('main', worksheet.name()+'!$A$1:$A$3')
positive_max_cell = xl_rowcol_to_cell(positive_len -1,1)
workbook.define_name('positivo', worksheet.name()+'!$B$1:'+ positive_max_cell)
negative_max_cell = xl_rowcol_to_cell(negative_len -1,2)
workbook.define_name('negativo', worksheet.name()+'!$C$1:'+ negative_max_cell)
neutral_max_cell = xl_rowcol_to_cell(neutral_len -1,3)
workbook.define_name('neutro', worksheet.name()+'!$D$1:'+ neutral_max_cell)

worksheet = workbook.add_worksheet
instrument = Instrument.where(name:"Wally Original").last
filter_from = 15.days.ago
filter_until = Time.now

evals = Evaluation.where(instrument_id: instrument.id, created_at: [filter_from..filter_until] )

items=  instrument.items
items_count = items.count

#worksheet.add_table(0,0,15,15, { :data=> info_table})
headers = ['id']
metrics_names = ["total_positivos", "total_negativos", "total_neutro", "positivos_sobre_negativos", "diferentes positivos utilizados"]
metrics_count = metrics_names.length
headers+=metrics_names
(0..items_count).step(1) do |item_index|
  user_index = item_index+1
  headers+= ["respuesta_#{user_index}", "clasificacion_#{user_index}"]
  (1..6).step(1){ |codification_index|
    headers+= ["codifcacion_#{codification_index}_#{user_index}"]
  }

end

name_by_value = {1=> "positivo", 2=>"negativo", 3=>"neutro"}

worksheet.write(0,0, headers)
table_start_row = 1
evals.each_with_index do |eval,eval_index|
  written_cols = 0
  row_index = eval_index + table_start_row
  worksheet.write(row_index,0, eval.id)
  written_cols+=1
  totals = {1=>0, 2=>0, 3=>0}
  (0..items_count-1).step(1) do |item_idx|
    item = items[item_idx]
    choice_answers =eval.choice_answers.where(choice: item.choices)
    unless choice_answers.empty?
      value = choice_answers.first.choice.choice_value
      totals[value] +=1
    end

  end

  different_1_count = eval.choices.where(choice_value:1).distinct.pluck(:choice_text).count
  ones_count = totals[1]
  twos_count = totals[2]
  threes_count = totals[3]

  ones_over_twos = nil?
  begin
    ones_over_twos = ones_count / twos_count
  rescue ZeroDivisionError => e
    print e
  end
  [ones_count,  twos_count, threes_count, ones_over_twos, different_1_count].each do |metric_value|
    worksheet.write(row_index, written_cols, metric_value)

    written_cols+=1
  end

  (0..items_count-1).step(1) { |item_index|
    item = items[item_index]
    col_index_item =written_cols+item_index*8
    item_id = items[item_index].id
    answer = OpenAnswer.where(evaluation_id: eval.id, item_id:item_id).first()

    if answer.nil?
      worksheet.write(row_index, col_index_item, "NO answer")
    else
      worksheet.write(row_index, col_index_item, answer.answer_text)
    end
    answers = eval.choice_answers.where(choice: item.choices)

    (0..6).step(1) { |selection_index|
      #generate the data validation
      selection_column = col_index_item + 1 + selection_index
      a1_notation = xl_rowcol_to_cell(row_index, selection_column-selection_index )
      if (selection_index == 0)
        formula = '=main'
      else
        formula ='=INDIRECT('+a1_notation +')'
      end

      if selection_index==0 and answers.length>0
        text=answers[0].choice.choice_value
        worksheet.write(row_index, selection_column, name_by_value[answers[0].choice.choice_value])
      end

      if answers[selection_index-1] and selection_index!=0
        worksheet.write(row_index, selection_column, answers[selection_index-1].choice.choice_text)
      end

      worksheet.data_validation(row_index, selection_column,{:validate => 'list', :value => formula})
    }
  }
end

workbook.close
return filepath
=begin
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
=end


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

