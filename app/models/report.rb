class Report < ApplicationRecord
  validates :title, presence: true
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
