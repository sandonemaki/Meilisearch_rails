class Book < ApplicationRecord
  include MeiliSearch::Rails

  belongs_to :user
  after_touch :index!
  # after_touch {User.reindex!}

  meilisearch {
    attribute :title, :price
    attribute :user do
      user.family_name
    end
  }

end
