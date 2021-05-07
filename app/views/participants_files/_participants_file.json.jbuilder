json.extract! participants_file, :id, :user_id, :year, :created_at, :updated_at
json.url participants_file_url(participants_file, format: :json)
