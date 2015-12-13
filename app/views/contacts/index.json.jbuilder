json.array!(@contacts) do |contact|
  json.extract! contact, :id, :first_name, :last_name, :phone_number, :opt_in, :user_id
  json.url contact_url(contact, format: :json)
end
