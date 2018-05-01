json.extract! course, :id, :title, :description, :duration_in_minutes, :min_group_size, :max_group_size, :series_id, :created_at, :updated_at, :to_s
json.url course_url(course, format: :json)
