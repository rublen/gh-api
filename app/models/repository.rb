class Repository < ApplicationRecord
  belongs_to :user

  def self.update_or_create_by(repo_id, attributes)
    repo = find_by(id: repo_id)
    repo ? repo.update(attributes) : create(id: repo_id, **attributes)
  end
end
