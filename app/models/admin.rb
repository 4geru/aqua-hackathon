class Admin < ApplicationRecord
  include Nyauth::Authenticatable
  #include Nyauth::Confirmable
end
