#parse the data that comes in a .xlsx file, save it for calculate metrics from the selected choices
module ExcelUtil
  require 'roo'
  require 'write_xlsx'
  include Writexlsx::Utility

  USER_SHEET_NAME = "Hoja1"
  def create_excel (instrument_id, instrument_id_2, users, date_from, date_until)
    instrument = Instrument.where(id:instrument_id).last
    second_instrument = Instrument.where(id: instrument_id_2).last
    choices = instrument.items[0].choices
    positive_value=1
    negative_value = 2
    neutral_value = 3

    time = Time.now.getutc.to_i
    filepath = "/tmp/detalles_#{time}.xlsx"

    # Create a new Excel workbook
        workbook = WriteXLSX.new(filepath)
    # Add a worksheet
    worksheet = workbook.add_worksheet("formato")
    worksheet.hide()
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

    worksheet = workbook.add_worksheet(USER_SHEET_NAME)
    filter_from = date_from
    filter_until = date_until

    evals = Evaluation.where(instrument_id: [instrument.id, second_instrument.id],  user:users, created_at: [filter_from..filter_until]).order("id ASC")
    items=  instrument.items
    items_count = items.count

#worksheet.add_table(0,0,15,15, { :data=> info_table})
    headers = ['id']
    metrics_names = ["total_positivos", "total_negativos", "total_neutro", "positivos_sobre_negativos", "diferentes positivos utilizados"]
    metrics_count = metrics_names.length

    headers+=metrics_names
    (0..items_count-1).step(1) do |item_index|
      user_index = item_index+1
      headers+= ["respuesta_#{user_index}", "clasificacion_#{user_index}"]
      (1..6).step(1){ |codification_index|
        headers+= ["codificacion_#{codification_index}_#{user_index}"]
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
      items = eval.instrument.items
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
  end


  def read_excel(filepath, instruments, users)
    data = Roo::Spreadsheet.open(filepath)
    data.default_sheet= USER_SHEET_NAME

    required_headers = []
    required_headers << 'id'
    items_count = instruments[0].items.count

    (1..items_count).each do |item_idx_human|
      (1..6).each do |codif_idx_human|
        required_headers << "codificacion_#{codif_idx_human}_#{item_idx_human}"
      end
    end

    headers = data.row(1)
    meet_all_headers = true
    missing_columns = []
    required_headers.each do |h|
      unless headers.include?h
        meet_all_headers=false
        missing_columns << h
      end
    end

    unless meet_all_headers
      errors_details  =["Las cabeceras de la tabla no son correctas, faltaron: #{missing_columns.join('; ')} "]
      return {errors_details: errors_details, modified_rows: 0}
    end

    modified_rows = 0
    errors = 0
    errors_texts = []
    conflictive_words = []

    data.each_with_index do |row, idx|
      next if idx==0
      eval_data = Hash[[headers,row].transpose]
      evaluation = Evaluation.find(eval_data['id'])

      instrument = evaluation.instrument
      items_count = instrument.items.count

      n_modified_items = 0
      (0..items_count-1).step(1) do |item_idx|

        modified_choices = 0
        item = instrument.items[item_idx]
        choices = item.choices
        item_idx_human = item_idx+1
        clasification = eval_data["clasificacion_#{item_idx_human}"]

        answers = []
        (1..6).step(1) do |codification_idx|
          col_name = "codifcacion_#{codification_idx}_#{item_idx_human}"
          codification = eval_data["codificacion_#{codification_idx}_#{item_idx_human}"]

          if codification.nil? or codification.blank?
            puts "BLANK"
            next
          end

          matched_choices = choices.select{|choice| choice.choice_text.downcase == codification.downcase}
          if matched_choices.length == 0
            # selected choice invalid text error in the row idx, rejected
            puts "EXCEPTION TEXT: #{codification}"
            errors_texts<<"selección inválida en: fila ##{idx} #{col_name} : #{codification}"
            errors+=1
            conflictive_words<< codification
            next
          end

          modified_choices+=1
          selected_choice = matched_choices[0]
          answer = ChoiceAnswer.new(choice: selected_choice)
          answers << answer
        end

        if modified_choices>=1
          evaluation.choice_answers.where(choice: item.choices).delete_all
          evaluation.choice_answers += answers
          evaluation.save
          n_modified_items+=1
        end
      end
      unless n_modified_items == 0
        modified_rows+=1
      end
      conflictive_words = conflictive_words.uniq
    end

    errors_details = []
    unless conflictive_words.first(14).empty?
      errors_details<< "Se encontraron #{errors} problemas con las palabras: " + conflictive_words.first(14).join("; ")
    end

    return {errors_details: errors_details, modified_rows: modified_rows}
  end


end