class CreateSecurePasswords < ActiveRecord::Migration[6.0]
  def change
    create_table :secure_passwords do |t|
      t.string :url
      t.string :name
      t.string :notes
      t.string :password

      t.timestamps
    end
  end
end
