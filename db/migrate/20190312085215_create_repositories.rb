class CreateRepositories < ActiveRecord::Migration[5.2]
  def change
    create_table :repositories do |t|
      t.references :user, index: true
      t.string :name, null: false
      t.bigint :total_bytes, default: 0
      t.string :description
      t.string :license
      t.string :language
      t.integer :stars, default: 0
      t.integer :forks, default: 0
      t.integer :opend_issues, default: 0
      t.string :url

      t.timestamps
    end
  end
end
