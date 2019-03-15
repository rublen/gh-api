class Authorization < ApplicationRecord
  belongs_to :user

  after_create :pull_data

  scope :github, -> { where(provider: 'github') }

  private

  def pull_data
    Github::PullAndSaveDataJob.perform_now(user)
  end
end
