json.extract! ledger_category, :id, :name, :created_at, :updated_at, :to_s
json.url ledger_category_url(ledger_category, format: :json)
