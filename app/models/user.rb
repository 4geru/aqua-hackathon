class User < ApplicationRecord
  include Nyauth::Authenticatable
  include Nyauth::Confirmable

  has_many :user_machines
end
