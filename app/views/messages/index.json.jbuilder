json.array!(@messages) do |message|
  json.extract! message, :id, :body, :to, :from, :status
  json.url message_url(message, format: :json)
end
