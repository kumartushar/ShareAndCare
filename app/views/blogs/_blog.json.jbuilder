json.extract! blog, :id, :title, :category, :sub_category, :description, :published_status, :published_on, :created_at, :updated_at
json.url blog_url(blog, format: :json)