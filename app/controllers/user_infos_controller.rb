class UserInfosController < ApplicationController
  before_filter :require_access_token

  def show
    render json: current_token.account.to_response_object(current_token)
  end
end
