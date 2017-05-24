class PasswordResetsController < ApplicationController
  def new
  end
  
  def create
    if (params[:email]).present?
      @user = User.find_by_email(params[:email])
      if @user.nil?
        flash[:error] = "O e-mail digitado não corresponde a um usuário"
        render :new
      else
        @user.send_password_reset
        flash[:info] = "Um email foi enviado com as intruções de recuperação"
        redirect_to url_for controller: :users, action: :login
        return
      end
    end
  end
  
  def edit
    @user = User.find_by_password_reset_token(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      flash[:notice] = "Recuperação de senha expirada, solicite um novo link"
      render :new
    end
  end
  
  def update
    @user = User.find_by_password_reset_token(params[:id])
    if (params[:user]).present?
      @user.salt = nil
      @user.password = params[:user][:password]
      @user.save
      redirect_to root_path, :notice => "Senha redefinida com sucesso!"
    else
      render :edit
    end
  end
end
