class User < ActiveRecord::Base
    has_secure_password
    before_save :downcase_email
    validates :email, uniqueness: true, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :password, presence: true, length: { minimum: 2 }
    validates :password_confirmation, presence: true
    
    def self.authenticate_with_credentials(email, password)
        email = email.strip.downcase
        user = User.find_by_email(email)
        user && user.authenticate(password)
    end
    private 

    def downcase_email
        self.email.downcase
    end

end
