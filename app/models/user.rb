class User < ApplicationRecord
	has_secure_password
	has_many :friend_lists, dependent: :delete_all
end
