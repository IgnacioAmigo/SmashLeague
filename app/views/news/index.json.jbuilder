json.array!(@news) do |news|
  json.extract! news, :id, :id, :body, :user_id, :show
  json.url news_url(news, format: :json)
end
