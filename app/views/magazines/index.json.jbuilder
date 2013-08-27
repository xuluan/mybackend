json.array!(@magazines) do |magazine|
  json.extract! magazine, :title
  json.url magazine_url(magazine, format: :json)
end
