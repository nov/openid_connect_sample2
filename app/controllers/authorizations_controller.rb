class AuthorizationsController < ApplicationController
  include Concerns::ConnectEndpoint

  before_action :require_oauth_request
  before_action :require_response_type_code
  before_action :require_client
  before_action :require_authentication

  def new
  end

  def create
    if params[:commit] == 'approve'
      authorization = current_account.authorizations.create(
        client: @client,
        nonce: oauth_request.nonce
      )
      authorization.scopes << requested_scopes
      oauth_response.code = authorization.code
      oauth_response.redirect_uri = @redirect_uri
      oauth_response.approve!
      redirect_to oauth_response.location
    else
      oauth_request.access_denied!
    end
  end

  private

  def require_client
    @client = Client.find_by(identifier: oauth_request.client_id) or oauth_request.invalid_request!
    @redirect_uri = oauth_request.verify_redirect_uri! @client.redirect_uri
  end

  def requested_scopes
    @requested_scopes ||= Scope.where(name: oauth_request.scope.split)
  end
  helper_method :requested_scopes

  def require_response_type_code
    unless oauth_request.response_type == :code
      oauth_request.unsupported_response_type!
    end
  end
end
