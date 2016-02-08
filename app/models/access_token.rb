class AccessToken < ApplicationRecord
  belongs_to :authorization
  has_and_belongs_to_many :scopes
end
