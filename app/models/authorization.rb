class Authorization < ApplicationRecord
  belongs_to :user

  scope :github, -> { where(provider: 'github') }
end
