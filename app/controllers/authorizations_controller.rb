class AuthorizationsController < ApplicationController
  def new
  end

  def create
    authorization.save!
    separator = if current_client.redirect_uri.include?('?')
      '&'
    else
      '?'
    end
    redirect_to [current_client.redirect_uri, {code: authorization.code, state: accepted_params[:state]}.to_query].join(separator)
  end

  private

  def authorization
    unless @authorization
      @authorization = current_account.authorizations.build(
        client: current_client,
        nonce: accepted_params[:nonce]
      )
      @authorization.scopes << requested_scopes
    end
    @authorization
  end
  helper_method :authorization

  def accepted_params
    required_params = [:client_id, :response_type, :redirect_uri, :scope]
    optional_params = [:nonce, :state]
    required_params.each do |key|
      params.require key
    end
    if params[:response_type] != 'code'
      raise HttpError::BadRequest.new('only respose_type=code is supported')
    end
    params.permit *(required_params + optional_params)
  end
  helper_method :accepted_params

  def requested_scopes
    @requested_scopes ||= Scope.where name: accepted_params[:scope].split
  end
  helper_method :requested_scopes

  def current_client
    @current_client ||= Client.find_by!(
      identifier: accepted_params[:client_id],
      redirect_uri: accepted_params[:redirect_uri]
    )
  end
  helper_method :current_client
end
