class DiscoveryController < ApplicationController
  def show
    case params[:id]
    when 'webfinger'
      webfinger_discovery
    when 'openid-configuration'
      openid_configuration
    else
      raise HttpError::NotFound
    end
  end

  private

  def webfinger_discovery
    jrd = {
      links: [{
        rel: OpenIDConnect::Discovery::Provider::Issuer::REL_VALUE,
        href: IdToken.config[:issuer]
      }]
    }
    jrd[:subject] = params[:resource] if params[:resource].present?
    render json: jrd, content_type: Mime::JRD
  end

  def openid_configuration
    config = OpenIDConnect::Discovery::Provider::Config::Response.new(
      issuer: IdToken.config[:issuer],
      authorization_endpoint: new_authorization_url,
      token_endpoint: tokens_url,
      userinfo_endpoint: user_info_url,
      jwks_uri: jwks_url,
      scopes_supported: Scope.all.collect(&:name),
      response_types_supported: [:code],
      grant_types_supported: [:authorization_code],
      subject_types_supported: [:public],
      id_token_signing_alg_values_supported: [:RS256],
      token_endpoint_auth_methods_supported: ['client_secret_basic', 'client_secret_post'],
      claims_supported: ['sub', 'iss', 'name', 'email', 'address', 'phone_number']
    )
    render json: config
  end
end
