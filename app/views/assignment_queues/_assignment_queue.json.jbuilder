json.extract! assignment_queue, :id, :assignment_order, :status, :user_id, :training_request_id, :created_at, :updated_at
json.url assignment_queue_url(assignment_queue, format: :json)
