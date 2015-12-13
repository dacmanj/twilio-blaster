json.array!(@group_memberships) do |group_membership|
  json.extract! group_membership, :id, :group_id, :contact_id, :role
  json.url group_membership_url(group_membership, format: :json)
end
