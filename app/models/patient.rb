class Patient < ActiveRecord::Base

  has_one :google_account

  # attr_accessible :title, :body
end
