class ChangeIdFormatInGoogleAccount < ActiveRecord::Migration
  def up
  	change_column :google_accounts, :id, :bigint
  end

  def down
  	change_column :google_accounts, :id, :integer
  end
end
