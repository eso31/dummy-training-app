json.extract! training_session, :id, :title, :description, :min_group_size, :max_group_size, :start_date, :url, :duration_in_minutes, :compensation, :compensation_delivered, :session_type, :course_id, :class_location_id, :created_at, :updated_at, :to_s
json.url training_session_url(training_session, format: :json)
