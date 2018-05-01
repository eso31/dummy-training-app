json.extract! general_ledger, :id, :transaction_type, :description, :transaction_date, :amount, :financial_account_id, :training_request_id, :ledger_category_id, :training_session_id, :created_at, :updated_at
json.url general_ledger_url(general_ledger, format: :json)
