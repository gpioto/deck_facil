class UserMailer < ActionMailer::Base
    default :from => "noreplydeckfacil@gmail.com"

    def registration_confirmation(user)
        @user = user
        mail(:to => "#{user.name} <#{user.email}>", :subject => "Confirmação de Cadastro")
    end
    
    def password_reset(user)
        @user = user
        mail :to => user.email, :subject => "Password Reset"
    end
end    