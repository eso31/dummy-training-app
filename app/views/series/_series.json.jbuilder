json.extract! series, :id, :name, :description, :created_at, :updated_at, :to_s
json.url series_url(series, format: :json)
