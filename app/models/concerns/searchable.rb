module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    mapping do
      # indexes :tag_name, type: 'text'
      indexes :tag_name, type: 'text' if self == Tag
      indexes :title, type: 'text' if self == Recipe
      indexes :description, type: 'text' if self == Recipe
    end

    def self.search(query)
      params = {
        query: {
          multi_match: {
            query: query,
            fields: ['tag_name', 'title', 'description'],
            fuzziness: "AUTO"
          }
        }
      }

      self.__elasticsearch__.search(params).records.to_a
    end
  end
end