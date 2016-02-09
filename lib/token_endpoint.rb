class TokenEndpoint
  attr_accessor :app
  delegate :call, to: :app

  def initialize
    @app = Rack::OAuth2::Server::Token.new do |req, res|
      client = Client.find_by(
        identifier: req.client_id,
        secret: req.client_secret,
        redirect_uri: req.redirect_uri
      ) || req.invalid_client!
      case req.grant_type
      when :authorization_code
        authorization = client.authorizations.valid.find_by(code: req.code) || req.invalid_grant!
        res.access_token = authorization.access_token.to_bearer_token
        res.id_token = authorization.id_token.to_jwt if authorization.scopes.include?(Scope::OPENID)
      else
        req.unsupported_grant_type!
      end
    end
  end
end