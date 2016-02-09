class Account < ApplicationRecord
  has_many :authorizations

  before_validation :setup, on: :create

  def to_response_object(access_token)
    userinfo = OpenIDConnect::ResponseObject::UserInfo.new
    if access_token.scopes.include? Scope::OPENID
      userinfo.subject = identifier
    end
    if access_token.scopes.include? Scope::PROFILE
      userinfo.name = 'Fake Account'
    end
    if access_token.scopes.include? Scope::EMAIL
      userinfo.email = 'fake@example.com'
      userinfo.email_verified = false
    end
    if access_token.scopes.include? Scope::ADDRESS
      userinfo.address = {
        formatted: 'Shibuya, Tokyo, Japan'
      }
    end
    if access_token.scopes.include? Scope::PHONE
      userinfo.phone_number = '+81 (3) 1234 5678'
      userinfo.phone_number_verified = false
    end
    userinfo
  end

  private

  def setup
    self.identifier = SecureRandom.hex 16
  end
end
