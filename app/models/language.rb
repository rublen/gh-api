class Language < ApplicationRecord
  has_many :github_lang_totals
  has_many :repositories, through: :github_lang_totals, source: :langable, source_type: "Repository"

  def repos_of(user)
    repositories.where(user: user)
  end
end
