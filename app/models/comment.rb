class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user
  validates_presence_of :body
  validates_presence_of :user
end
