json.extract! question, :id, :question, :answer, :is_public, :user_id, :created_at, :updated_at
json.url question_url(question, format: :json)
