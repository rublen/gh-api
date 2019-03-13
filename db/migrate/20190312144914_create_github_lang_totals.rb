class CreateGithubLangTotals < ActiveRecord::Migration[5.2]
  def change
    create_table :github_lang_totals do |t|
      t.references :langable, polymorphic: true
      t.references :language, foreign_key: true
      t.integer :repos_count, default: 0
      t.bigint :bytes, default: 0
      t.float :percent

      t.timestamps
    end
  end
end
