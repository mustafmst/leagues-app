class User < ApplicationRecord
    validates :login, uniqueness: true
    has_many :contestants, :class_name => 'Contestant'
    has_many :leagues, :class_name => 'League'

    require 'digest/md5'
    
    def getGravatarLink(size)
        emailHash = Digest::MD5.hexdigest(self[:email])
        return "https://www.gravatar.com/avatar/#{emailHash}?s=#{size}"
    end

    def securePassword
        self[:password] = Digest::MD5.hexdigest(self[:password])
    end

    def update_password(new_password)
        self.update :password => Digest::MD5.hexdigest(new_password)
    end

    def checkPassword(providedPassword)
        return self[:password] == Digest::MD5.hexdigest(providedPassword)
    end

    def destroy_all
        self.contestants.each do |c|
            c.destroy
        end
        self.leagues.each do |l|
            l.destroy
        end
        self.destroy
    end

end
