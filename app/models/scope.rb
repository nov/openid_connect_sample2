class Scope < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  include ConstantCache
  cache_constants
end
