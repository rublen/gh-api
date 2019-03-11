class CreateAuthorizations < ActiveRecord::Migration[5.2]
  def change
    create_table :authorizations do |t|
      t.references :user, index: true
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :email
      t.string :token

      t.timestamps
    end

    add_index :authorizations, [:uid, :provider], unique: true
  end
end
