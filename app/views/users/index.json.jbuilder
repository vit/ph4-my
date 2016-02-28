json.array!(@users) do |user|
  json.extract! user, :id, :show
  json.url user_url(user, format: :json)
end
