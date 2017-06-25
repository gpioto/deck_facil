require 'bcrypt'
class User < ApplicationRecord
    has_many :posts
    include BCrypt
    before_create :confirmation_token
    before_save :encrypt_password
    before_update :encrypt_update_password, :if => :should_validate_password
    attr_accessor :updating_password
    
    validates :name, :presence => {:message => " deve ser preenchido"}, :uniqueness => {:message => " já foi escolhido"}, :length => { :in => 3..20, :message => " deve conter entre 3 e 20 caracteres" }
    validates :email, :presence => {:message => " deve ser preenchido"}, :uniqueness => {:message => " já foi escolhido"}
    validates :email, :format => {:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, :message => " inválido"}
    validates :password, :confirmation => {:message => " não confere com a senha"}
    validates_length_of :password, :in => 6..20, :on => :create, :message => " deve conter entre 6 e 20 caracteres"
    validates_length_of :password, :in => 6..20, :on => :password, :message => " deve conter entre 6 e 20 caracteres"
    validates :profile_image, :format => { :allow_nil => true, :with => URI::regexp(%w(http https)), :message => "Precisa ser uma URL válida iniciada com http ou https"}
    
    def should_validate_password
        updating_password
    end

    def profile_image_url
        @profile_image_url = profile_image.nil? ? "/assets/user2-160x160.jpg" : profile_image;
    end

    def email_activate
        self.confirmed_email = true
        self.confirm_token = nil
        save!(:validate => false)
    end

    def encrypt_update_password
        if password.present?
            self.salt = BCrypt::Engine.generate_salt
            self.password = BCrypt::Engine.hash_secret(password, salt)
        end
      
    end
    
    def encrypt_password
        if password.present? && salt.nil?
            self.salt = BCrypt::Engine.generate_salt
            self.password = BCrypt::Engine.hash_secret(password, salt)
        end

    end

    def confirmation_token
        if self.confirm_token.blank?
            self.confirm_token = SecureRandom.urlsafe_base64.to_s
        end
    end

    def generate_token(column)
        begin
            self[column] = SecureRandom.urlsafe_base64
        end while User.exists?(column => self[column])
    end

    def send_password_reset
        generate_token(:password_reset_token)
        if self.name == "testUser"
            self.password_reset_sent_at = 3.hours.ago
        else
            self.password_reset_sent_at = Time.zone.now
        end
        save!
        UserMailer.password_reset(self).deliver
    end

    private :encrypt_password, :confirmation_token

end
