class User < ApplicationRecord

  has_secure_password

  validates :username, length: { in: 4..15 }
  validates :password, length: { in: 6..15 }

end
