class Authorization < ApplicationRecord
  belongs_to :account
  belongs_to :client
  has_one :access_token
  has_and_belongs_to_many :scopes
end
