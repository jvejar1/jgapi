require 'csv_utilities'
study = Study.find(18)
puts study.moments.as_json
instrument = Instrument.find(4)
schools = School.find(study.courses.pluck(:school_id))

File.open('report.csv', 'w') { |file| file.write(generate_report(instrument,study, schools) ) }

