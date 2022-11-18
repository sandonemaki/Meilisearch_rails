class Book < ApplicationRecord
  include MeiliSearch::Rails

  belongs_to :user
  after_touch :index!

  meilisearch {
    attribute :title, :price
    attribute :user do
      user.family_name
    end
  }

end
