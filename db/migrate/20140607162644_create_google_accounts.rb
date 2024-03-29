class CreateGoogleAccounts < ActiveRecord::Migration
  def change
    create_table :google_accounts do |t|
      t.string :token
      t.string :refresh_token
      t.integer :expires_at
      t.string :email
      t.string :name
      t.text :id_token
      t.string :verification_secret
      t.references :patient

      t.timestamps
    end
    add_index :google_accounts, :patient_id
  end
end
