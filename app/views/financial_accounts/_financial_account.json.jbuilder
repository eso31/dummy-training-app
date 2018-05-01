json.extract! financial_account, :id,
              :name,
              :status,
              :parent_account_id,
              :created_at,
              :updated_at,
              :to_s

json.url financial_account_url(financial_account, format: :json)
