class IdToken < ApplicationRecord
  belongs_to :authorization

  class << self
    def config
      issuer = 'http://op2.dev'
      {
        issuer: issuer,
        jwks_uri: File.join(issuer, 'jwks.json')
      }
    end
  end
end
