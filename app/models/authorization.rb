class Authorization < ApplicationRecord
  belongs_to :account
  belongs_to :client
  has_one :access_token
  has_and_belongs_to_many :scopes
  before_create :setup_code, :setup_expiry

  private

  def setup_code
    self.code = SecureRandom.hex 16
  end

  def setup_expiry
    self.expires_at = 5.minutes.from_now
  end
end
