module Concerns
  module Authentication
    def current_account
      # NOTE: implement end-user authentication logic by your own
      @current_account ||= Account.first || Account.create
    end

    def current_token
      @current_token ||= request.env[Rack::OAuth2::Server::Resource::ACCESS_TOKEN]
    end

    def require_access_token
      unless current_token
        raise Rack::OAuth2::Server::Resource::Bearer::Unauthorized.new
      end
    end
  end
end