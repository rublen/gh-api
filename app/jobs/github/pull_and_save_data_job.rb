class Github::PullAndSaveDataJob < ApplicationJob
  queue_as :default

  def perform(user)
    Github::PullAndSaveReposData.new(user).call
  end
end
