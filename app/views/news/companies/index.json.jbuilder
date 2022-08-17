json.contents do
  json.array! @news do |news|
    json.id news.id
    json.headline news.headline
    json.body news.body
    json.link_url news.link_url
    json.image_url news.image_url
    json.fetched_from news.fetched_from
    json.symbol news.symbol
    json.original_created_at news.original_created_at
    # @current_user can be nil, because the news can be accessed without login
    json.favored_by_current_user news.favored_by_user?(@current_user&.id)
  end
end

json.page do
  json.current_page @news.current_page
  json.next_page @news.next_page
  json.total_pages @news.total_pages
  json.prev_page @news.prev_page
  json.is_first_page @news.first_page?
  json.is_last_page @news.last_page?
end
