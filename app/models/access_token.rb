class AccessToken < ApplicationRecord
  belongs_to :authorization
  has_and_belongs_to_many :scopes

  before_validation :setup, on: :create

  scope :valid, lambda {
    where('expires_at >= ?', Time.now.utc)
  }

  delegate :account, :client, to: :authorization

  def to_bearer_token
    Rack::OAuth2::AccessToken::Bearer.new(
      access_token: token,
      expires_in: (expires_at - Time.now).to_i
    )
  end

  private

  def setup
    self.token = SecureRandom.hex 32
    self.expires_at = 1.hours.from_now
  end
end
