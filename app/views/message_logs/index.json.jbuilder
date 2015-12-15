json.array!(@message_logs) do |message_log|
  json.extract! message_log, :id, :to, :from, :status, :sid, :error_code, :error_message, :date_sent, :account_sid, :billing_reference, :message_id
  json.url message_log_url(message_log, format: :json)
end
