json.extract! secure_password, :id, :url, :name, :notes, :password, :created_at, :updated_at
json.url secure_password_url(secure_password, format: :json)
