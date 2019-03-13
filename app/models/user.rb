class User < ApplicationRecord
  has_many :authorizations, dependent: :destroy
  has_many :repositories, dependent: :destroy
  has_many :github_lang_totals, as: :langable, dependent: :destroy
  has_many :languages, through: :github_lang_totals

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github]
end
