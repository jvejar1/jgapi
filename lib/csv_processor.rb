class CSVProcessor
  def initialize
  end

  def process(csv,inserter,required_headers)
    headers=csv.headers
    required_headers.each do |required_header|
      if not headers.include? required_header
        raise 'Invalid headers, required: '+required_headers.join(", ")
        return
      end
    end

    csv.each do |row|
      inserter.insert(row)
    end

  end
end