class GithubLangTotal < ApplicationRecord
  belongs_to :language
  belongs_to :langable, polymorphic: true

  def self.update_or_create_by(lang, attributes)
    # for using in :langable association, for ex.: repo.github_lang_totals.update_or_create_by(lang, {...})
    gh_lang_total = find_by(language: lang) || new(language: lang, **attributes)
    gh_lang_total if gh_lang_total.update(attributes)
  end
end
