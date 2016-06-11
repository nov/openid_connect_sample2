require 'openid_connect'

OpenIDConnect.debug!

client = OpenIDConnect::Client.new(
  identifier: 'rp.dev',
  secret: '42347d901a6686a533067285ed13ee1b475121a6ece10446299f4be62e4e4bfc',
  redirect_uri: 'http://rp.dev/providers/3/open_id',
  host: 'op2.dev',
  scheme: 'http',
  authorization_endpoint: '/authorizations/new',
  token_endpoint: '/tokens',
  userinfo_endpoint: '/user_info'
)

redirect_uri = client.authorization_uri(
  scope: [:email, :profile],
  state: SecureRandom.hex(8),
  nonce: SecureRandom.hex(8)
)

puts redirect_uri
`open "#{redirect_uri}"`

print 'code: ' and STDOUT.flush
code = gets.chop

client.authorization_code = code
client.access_token!