class User < ActiveRecord::Base
  has_secure_password
  has_one :api_key, dependent: :destroy
end
