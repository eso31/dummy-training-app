json.extract! user, :id, :email, :first_name, :full_name, :last_name, :to_s, :created_at, :updated_at
json.url user_url(user, format: :json)
