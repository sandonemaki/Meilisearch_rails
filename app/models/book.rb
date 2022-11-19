class Book < ApplicationRecord
  include MeiliSearch::Rails

  belongs_to :user
  after_touch :index!
  after_save :user_save
  def user_save
    User.reindex!
  end

  meilisearch {
    attribute :title, :price
    attribute :user do
      user.family_name
    end
  }

end
