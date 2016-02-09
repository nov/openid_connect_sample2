class Account < ApplicationRecord
  has_many :authorizations
  before_create :setup_identifier

  private

  def setup_identifier
    self.identifier = SecureRandom.hex 16
  end
end
