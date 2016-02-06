json.array!(@movies) do |movie|
  json.extract! movie, :id, :Title, :Description, :Duration, :Actor, :Rating
  json.url movie_url(movie, format: :json)
end
