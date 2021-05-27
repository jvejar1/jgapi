class CSVProcessor
  @inserter=nil

  def inserter
    @inserter
  end
  def inserter=(value)
    @inserter=value
  end

  def initialize
    @errors = []
  end

  def process(csv,inserter,required_headers, insert_method=nil)
    self.inserter=inserter
    headers=csv.headers
    required_headers.each do |required_header|
      if not headers.include? required_header
        raise 'Headers invalidos, requeridos: '+required_headers.join(", ")
        errors<< required_headers.join(", ")+"."
        return
      end
    end

    csv.each_with_index do |row,idx|
      row["index"]=idx
      unless insert_method.nil?
        insert_method.call(row)
      else
        self.inserter.insert(row)
      end
    end
  end

  def report_str
    text = ""
    if @errors.count>0
      text+="#{@errors.join' '}"
    end
    text+=""
  end
end