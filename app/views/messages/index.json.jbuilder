json.array!(@messages) do |message|
  json.extract! message, :id, :body, :to_phone_number, :from_phone_number, :status
  json.url message_url(message, format: :json)
end
