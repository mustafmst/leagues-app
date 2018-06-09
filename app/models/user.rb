class User < ApplicationRecord
    validates :login, uniqueness: true
end
