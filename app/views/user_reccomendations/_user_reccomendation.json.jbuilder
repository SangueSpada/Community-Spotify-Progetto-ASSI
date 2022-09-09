json.extract! user_reccomendation, :id, :created_at, :updated_at
json.url user_reccomendation_url(user_reccomendation, format: :json)
