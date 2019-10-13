require File.expand_path('../../config/environment', __FILE__)
require 'csv'
current_ace=Ace.find_by(current:true)
acases=current_ace.acases

###HEADERS

headers= []
##StudentInfo
headers+=["Rut", "Nombres", "Colegio","Curso","Grupo"]
moments = [Moment.new(from:"2018-01-01", until:"2018-10-01"), Moment.new(from:"2018-10-02", until:"2019-12-12")]
moments.each do |moment|
  headers<< "Momento %s - %s" %[moment.from, moment.until]
  headers+=["Evaluador","Fecha Aplicacion","Fecha Servidor","Puntaje Maximo","Puntaje total"]
  column_index = 1
  acases.each do |acase|
    headers<<"Aces "+column_index.to_s
    headers<<"Respuesta Aces "+column_index.to_s
    column_index+=1
  end

end

####

csv_body = []

evaluations = Evaluation.where(ace:current_ace).limit(100)
students= evaluations.map{|evaluation| evaluation.student}
students.each do |student|
  row = []
  row << student.rut
  row << student.last_name + ' ' + student.name
  row << student.course.school.name
  row << student.course.get_full_name()
  row << student.course.school.group

  #iterate over the moments to get each evaluation result with the evaluation info
  moments.each do |moment|

    #add moment separator
    row<<nil
    #get the (first/unique) corresponding evaluation for that period
    evaluation = evaluations.where(student:student,realized_at:moment.from..moment.until,ace:current_ace).first
    if evaluation.nil?
      evaluator_user = nil
      evaluation_date = nil
      evaluation_received_date = nil
    else
      evaluator_user = evaluation.user.email
      evaluation_date = evaluation.realized_at
      evaluation_received_date = evaluation.created_at
    end

    row<<evaluator_user
    #dates
    row<<evaluation_date
    row<<evaluation_received_date

    evaluation_results = []
    total_score = 0
    acases.each do |acase|
      answer=AcaseAnswer.find_by(acase:acase,evaluation:evaluation)
      if !answer.nil?
        evaluation_results<<answer.score
        total_score+=answer.score
        evaluation_results<<answer.selected_feeling
      else
        evaluation_results<<nil
        evaluation_results<<nil
      end
    end

    max_score=nil
    evaluation_results.insert(0,max_score)
    evaluation_results.insert(1,total_score)
    row+=evaluation_results
  end
  csv_body << row

end
puts("Fin")

require 'csv'
CSV.open("myfile.csv", "w") do |csv|
  csv<<headers
  csv_body.each do |csv_line|
    csv<<csv_line
  end
  # ...
end
return

evaluations = current_ace.evaluations

csv_string = CSV.generate do |csv|

  #generate the info table

  max_score=acases.where(distractor:false).count

  row=["Puntaje maximo",max_score]
  csv<<row

  info_rows=[]
  info_rows.each do |info_row|
    csv<<info_row
  end
  csv<<[]


  csv << headers
  evaluations.each do |evaluation|
    row=[]
    row<<evaluation.user.email
    #dates
    row<<evaluation.realized_at.to_date
    row<<evaluation.created_at.to_date
    #get and puts student info

    student=evaluation.student
    row<<student.rut
    row<<student.last_name+" "+student.name
    total_score=0

    acases.each do |acase|
      answer=AcaseAnswer.find_by(acase:acase,evaluation:evaluation)
      if !answer.nil?
        row<<answer.score

        total_score+=answer.score
        row<<answer.selected_feeling
      else
        row<<"N/A"
        row<<"N/A"
      end
    end
    row.insert(5,total_score)
    csv<<row
  end
end

