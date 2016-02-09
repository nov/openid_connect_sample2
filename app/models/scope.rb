class Scope < ApplicationRecord
  include ConstantCache
  cache_constants
end
