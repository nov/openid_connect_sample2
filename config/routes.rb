Rails.application.routes.draw do
  resources :authorizations, only: [:new, :create]
  resource :user_info, only: :show

  get '.well-known/:id', to: 'discovery#show'
  post 'access_tokens', to: proc { |env| [200, {}, ['fake']] }
  get  'jwks.json',     to: proc { |env| [200, {'Content-Type' => 'application/json'}, [IdToken.config[:jwk_set].to_json]] }
end
