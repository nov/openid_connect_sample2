class IdToken < ApplicationRecord
  belongs_to :authorization

  before_validation :setup, on: :create

  delegate :account, :client, to: :authorization

  def to_response_object
    OpenIDConnect::ResponseObject::IdToken.new(
      iss: self.class.config[:issuer],
      sub: account.identifier,
      aud: client.identifier,
      nonce: nonce,
      exp: expires_at.to_i,
      iat: created_at.to_i
    )
  end

  def to_jwt
    to_response_object.to_jwt(self.class.private_jwk)
  end

  private

  def setup
    self.expires_at = 1.hours.from_now
  end

  class << self
    def key_pair
      # NOTE: usually static file.
      @key_pair ||= OpenSSL::PKey::RSA.generate 2048
    end

    def private_jwk
      JSON::JWK.new key_pair
    end

    def public_jwk
      JSON::JWK.new key_pair.public_key
    end

    def config
      {
        issuer: 'http://op2.dev',
        jwk_set: JSON::JWK::Set.new(public_jwk)
      }
    end
  end
end
