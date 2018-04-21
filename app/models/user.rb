class User < ApplicationRecord
  include Nyauth::Authenticatable
  include Nyauth::Confirmable
end
