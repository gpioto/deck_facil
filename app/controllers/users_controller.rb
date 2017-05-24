require 'bcrypt'

class UsersController < ApplicationController
    include BCrypt
    
    def new
        @user = User.new
    end
  
    def login
        
        if !session[:user_id].nil?
            @user = User.find_by id: session[:user_id]
            if !@user.nil?
                redirect_to :controller => 'dashboard', :action => 'dashboard' 
                return
            end
        end
        
        if (params[:user]).present?  
            @user = User.find_by name: params[:user][:name]
            
            if !@user.nil?
            
                @password = BCrypt::Engine.hash_secret(params[:user][:password], @user.salt)
                if @password == @user.password
                    redirect_to :controller => 'dashboard', :action => 'dashboard'
                    session[:user_id] = @user.id
                    if @user.confirmed_email
                        update_login_data
                        flash[:notice] = "Login realizado com sucesso!"
                    else
                        update_login_data
                        flash[:alert] = "Por favor, confirme seu e-mail para ativar sua conta"
                    end
                    return
                else
                    flash.now[:danger] = "Senha inválida"
                end
                
            else
                flash.now[:danger] = "Nome de usuário inválido"
            end
            
        end 
        render "login"
    end
  
    def create
        if (params[:user]).present?  
            @user = User.new(user_params)
            if @user.save
                begin
                  UserMailer.registration_confirmation(@user).deliver
                    flash[:success] = "#{@user.name} created"
                  rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError
                   flash[:success] = "#{@user.name} created"
                end
                flash[:success] = "Cadastro realizado com sucesso"
                render "login"
                return
            else
                #flash.now[:error] = "Dados inválidos"
            end
            
        end
        
        render "new"
    end
    
    def confirm_email
    user = User.find_by confirm_token: params[:id]
        if user
            user.email_activate
            flash[:success] = "Seja bem-vindo ao Restrot. Faça login para continuar"
            render "login"
        else
            flash[:error] = "Usuário inexistente"
            redirect_to :controller => 'home', :action => 'index' 
        end
    end
    
    private 
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :created_at, :updated_at)
    end
    
    def update_login_data
        user = User.where(:id => session[:user_id]).first
        user.increment!(:logins)
        user.update_attribute(:updated_at, Time.now) 
        user.save()
    end
end
