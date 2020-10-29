class Report < ApplicationRecord
  has_many :comments, as: :commentable

  validates :title, presence: true
  validates :practice_status, presence: true
  validates :feeling_status, presence: true
  validates :learning_day, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :content, presence: true

  enum practice_status: {
    html_css: 0,
    ruby_on_rails: 1,
    javascript: 2
  }
  enum feeling_status: {
    normal: 0,
    bad: 1,
    good: 2
  }
end
