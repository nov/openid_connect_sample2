class Account < ApplicationRecord
  has_many :authorizations

  before_validation :setup, on: :create

  private

  def setup
    self.identifier = SecureRandom.hex 16
  end
end
