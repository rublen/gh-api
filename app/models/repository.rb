class Repository < ApplicationRecord
  belongs_to :user
  has_many :github_lang_totals, as: :langable, dependent: :destroy
  has_many :languages, through: :github_lang_totals

  def self.update_or_create_by(repo_id, attributes)
    repo = find_by(id: repo_id)
    repo ? repo.update(attributes) : create(id: repo_id, **attributes)
  end
end
