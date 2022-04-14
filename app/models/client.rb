class Client < ApplicationRecord
    has_secure_password
    has_many :carte_informations
    has_many :reservations
    before_create :confirmation_token

    def email_activate
        self.email_confirmed = true
        self.confirm_token = nil
        save!(:validate => false)
    end
    def generate_password_token!
        self.reset_password_token = generate_token
        self.reset_password_sent_at = Time.now.utc
        save!
    end

    def password_token_valid?
        (self.reset_password_sent_at + 24.hours) > Time.now.utc
    end

    def reset_password!(password)
        self.reset_password_token = nil
        self.password = password
        save!
    end

    private
    def confirmation_token
        if self.confirm_token.blank?
            self.confirm_token = SecureRandom.urlsafe_base64.to_s
        end
    end
    def generate_token
        SecureRandom.hex(10)
    end

end

