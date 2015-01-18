json.array!(@matches) do |match|
  json.extract! match, :id, :challenger_id, :challenged_id, :challenger_won, :description, :proof
  json.url match_url(match, format: :json)
end
