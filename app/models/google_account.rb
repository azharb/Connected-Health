class GoogleAccount < ActiveRecord::Base
  set_primary_key "id"
  belongs_to :patient
  before_create :generate_verification_secret
  after_create :subscribe_to_google_notifications
  attr_accessible :email, :name, :refresh_token, :token, :expires_at, :id_token, :id, :google_account_id
  
  def token_expiry
    Time.at(self.expires_at)
  end
  def has_expired_token?
    token_expiry < Time.now
  end
  def update_google_tokens(google_auth_hash)
    [:token, :id_token, :expires_at].each do |attribute|
      self.send("#{attribute}=", google_auth_hash[attribute.to_s])
    end
    self.save
  end

  def subscribe_to_google_notifications
    subscription = Glass::Subscription.new google_account: self
    subscription.insert()
  end
  def update_location(location)

  end
  def list
    Glass::Client.new(google_account: self).list
  end
  def cached_list
    Glass::Client.new(google_account: self).cached_list
  end
  private
  def generate_verification_secret
    self.verification_secret = SecureRandom.urlsafe_base64
  end
end
