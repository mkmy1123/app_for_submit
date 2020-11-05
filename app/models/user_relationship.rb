class UserRelationship < ApplicationRecord
  belongs_to :followed, class_name: "User"
  belongs_to :following, class_name: "User"
  validates :followed_id, presence: true
  validates :following_id, presence: true
end
