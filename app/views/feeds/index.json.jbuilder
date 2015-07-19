json.array!(@feeds) do |feed|
  json.extract! feed, :id, :name, :original_url, :last_pulled_at, :last_pushed_at, :last_body, :last_format
  json.url feed_url(feed, format: :json)
end
