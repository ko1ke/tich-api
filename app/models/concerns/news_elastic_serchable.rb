module NewsElasticSerchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model

    # index_name
    index_name "es_news_#{Rails.env}"

    # mapping info
    settings do
      mappings dynamic: 'false' do
        indexes :id, type: 'integer'
        indexes :headline, type: 'text'
        indexes :body, type: 'text'
        indexes :link_url, type: 'text'
        indexes :image_url, type: 'text'
        indexes :fetched_from, type: 'text'
        indexes :symbol, type: 'keyword'
        indexes :original_created_at, type: 'date'
      end
    end

    # generate document according to definition of mapping
    def as_indexed_json(*)
      attributes
        .symbolize_keys
        .slice(:id, :headline, :body, :link_url, :image_url, :fetched_from, :symbol, :original_created_at)
    end
  end

  class_methods do
    def create_index!
      client = __elasticsearch__.client
      # delete index if exists
      begin
        client.indices.delete index: index_name
      rescue StandardError
        nil
      end
      client.indices.create(index: index_name,
                            body: {
                              settings: settings.to_hash,
                              mappings: mappings.to_hash
                            })
    end

    def index_exist?
      __elasticsearch__.index_exists?
    end

    def es_search(keyword = '', type = 'cross_fields', operator = 'and')
      __elasticsearch__.search({
                                 query: {
                                   multi_match: {
                                     fields: %w[headline body symbol],
                                     type: type,
                                     query: keyword,
                                     operator: operator
                                   }
                                 },
                                 "sort": [
                                   {
                                     "original_created_at": {
                                       "order": 'asc'
                                     }
                                   }
                                 ]
                               })
    end
  end
end
