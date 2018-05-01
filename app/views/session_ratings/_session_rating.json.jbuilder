json.extract! session_rating, :id, :rating, :user_type, :comment, :enrollment_id, :user_id, :created_at, :updated_at
json.url session_rating_url(session_rating, format: :json)
