json.extract! class_location, :id, :name, :email, :timezone, :created_at, :updated_at, :to_s
json.url class_location_url(class_location, format: :json)
