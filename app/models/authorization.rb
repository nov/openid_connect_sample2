class Authorization < ApplicationRecord
  belongs_to :account
  belongs_to :client
  has_one :access_token
  has_one :id_token
  has_and_belongs_to_many :scopes

  before_validation :setup, on: :create

  scope :valid, lambda {
    where('expires_at >= ?', Time.now.utc)
  }

  def expire!
    self.expires_at = Time.now
    self.save!
  end

  def access_token
    super || expire! && generate_access_token!
  end

  def id_token
    super || generate_id_token!
  end

  private

  def setup
    self.code = SecureRandom.hex 32
    self.expires_at = 5.minutes.from_now
  end

  def generate_access_token!
    token = build_access_token
    token.scopes << scopes
    token.save!
    token
  end

  def generate_id_token!
    token = build_id_token
    token.nonce = nonce
    token.save!
    token
  end
end
