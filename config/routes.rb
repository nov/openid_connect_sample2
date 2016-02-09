Rails.application.routes.draw do
  resources :authorizations, only: [:new, :create]
  resource :user_info, only: :show

  get '.well-known/:id', to: 'discovery#show'
  post 'tokens', to: proc { |env| TokenEndpoint.new.call(env) }
  get 'jwks.json', as: :jwks, to: proc { |env| [200, {'Content-Type' => 'application/json'}, [IdToken.config[:jwk_set].to_json]] }
end
