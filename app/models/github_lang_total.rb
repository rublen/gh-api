class GithubLangTotal < ApplicationRecord
  belongs_to :language
  belongs_to :langable, polymorphic: true
end
