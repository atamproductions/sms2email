json.array!(@messages) do |message|
  json.extract! message, :id, :body, :from, :to, :user_id
  json.url message_url(message, format: :json)
end
