class User < ApplicationRecord
    validates :login, uniqueness: true

    require 'digest/md5'
    
    def getGravatarLink(size)
        emailHash = Digest::MD5.hexdigest(self[:email])
        return "https://www.gravatar.com/avatar/#{emailHash}?s=#{size}"
    end

    def securePassword
        self[:password] = Digest::MD5.hexdigest(self[:password])
    end

    def checkPassword(providedPassword)
        return self[:password] == Digest::MD5.hexdigest(providedPassword)
    end
end
