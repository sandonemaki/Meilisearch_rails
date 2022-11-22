class User < ApplicationRecord
  include MeiliSearch::Rails

  has_many :books, dependent: :destroy
  after_save {books.each(&:touch)}

  meilisearch {
    attribute :family_name, :given_name, :age
    attribute :book do
      books.map(&:title).join(',')
    end
    searchable_attributes [:given_name, :family_name, :book, :age]
    filterable_attributes [:age]
  }
end
#  meilisearch {
#    attribute :family_name, :given_name, :age
#
#    searchable_attributes [:given_name, :family_name, :age]
#    sortable_attributes [:age]
#    filterable_attributes [:age]
#    ranking_rules [
#          'proximity',
#          'typo',
#          'words',
#          'attribute',
#          'sort',
#          'exactness',
#          'family_name:desc'
#        ]
#    attributes_to_highlight ['*']
#    attributes_to_crop [:given_name]
#    crop_length 10
#  }
#end
