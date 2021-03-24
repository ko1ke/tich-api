json.contents do
  json.array! @news, :id, :headline, :body,
              :link_url, :image_url, :fetched_from, :symbol,
              :original_created_at
end

json.page do
  json.current_page @news.current_page
  json.next_page @news.next_page
  json.total_pages @news.total_pages
  json.prev_page @news.prev_page
  json.is_first_page @news.first_page?
  json.is_last_page @news.last_page?
end
