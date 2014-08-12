class Post < ActiveRecord::Base
  belongs_to :user
  validates :content, :user, presence: true

  PAGE_SIZE = 20
  scope :page, ->(index) { offset((index.to_i - 1) * PAGE_SIZE).limit(PAGE_SIZE) }
end
