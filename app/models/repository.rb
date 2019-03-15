class Repository < ApplicationRecord
  belongs_to :user
  has_many :github_lang_totals, as: :langable, dependent: :destroy
  has_many :languages, through: :github_lang_totals

  scope :main_lang, -> (lang_name) { where language: lang_name }

  def self.update_or_create_by(repo_id, attributes)
    # for using in :user association, for ex.: user.repositories.update_or_create_by(repo.id, repo_data(repo))
    repo = find_by(id: repo_id) || new(id: repo_id, **attributes)
    repo if repo.update(attributes)
  end
end
