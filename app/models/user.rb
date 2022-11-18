class User < ApplicationRecord
  include MeiliSearch::Rails

  has_many :books
  after_save {books.each(&:touch)}

  meilisearch {
    attribute :first_name, :last_name, :age
    attribute :full_name do
      "#{first_name} #{last_name}"
    end

    searchable_attributes [:given_name, :family_name, :age]
    sortable_attributes [:age]
    filterable_attributes [:age]
    ranking_rules [
          'proximity',
          'typo',
          'words',
          'attribute',
          'sort',
          'exactness',
          'family_name:desc'
        ]
    attributes_to_highlight ['*']
    attributes_to_crop [:given_name]
    crop_length 10
  }
end
