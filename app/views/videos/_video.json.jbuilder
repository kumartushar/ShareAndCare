json.extract! video, :id, :title, :url, :created_at, :updated_at
json.url video_url(video, format: :json)