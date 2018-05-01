json.extract! training_request, :id, :name, :description, :location, :duration_in_minutes, :start_date, :end_date, :status, :reference_file, :assigned_to_user_id, :requested_by_user_id, :created_at, :updated_at, :to_s
json.url training_request_url(training_request, format: :json)
