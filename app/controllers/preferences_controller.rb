require 'bcrypt'
class PreferencesController < SessionController
include BCrypt
    
    layout 'admin_lte_2_prefs'
    
    def preferences
       redirect_to :action => "profile"
    end
    
    def profile
        @user = current_user
        
        if params[:user]
            @user.profile_name = params[:user][:profile_name]
            @user.profile_last_name = params[:user][:profile_last_name]
            @user.profile_image = params[:user][:profile_image_url]
            
            # File Upload has been deprecated, heroku doesn't support file uploading
            # uploaded_io = params[:user][:profile_image]
            #
            #
            # if !uploaded_io.nil? && !@user.name.nil?
            #    File.open(Rails.root.join('public', 'assets', 'profile_images', @user.name + ".jpg"), 'wb') do |file|
            #        file.write(uploaded_io.read)
            #    end
            # end
            
            if @user.save 
                flash[:notice] = "Perfil atualizado com sucesso!"
            else
                @user.errors.full_messages.each do |error| 
                    flash[:alert] = error
                end
            end
        end
        
        params[:user] = current_user
    end
    
    def password

        @user = current_user
        
        if params[:user]
            if(params[:user][:password] == params[:user][:passwordConfirmation])
                @password = BCrypt::Engine.hash_secret(params[:user][:oldPassword], @user.salt)
                if(@password == @user.password)
                    @user.password = params[:user][:password]
                    @user.updating_password = true;
                    if @user.save 
                        flash[:notice] = "Perfil atualizado com sucesso!"
                    else
                        @user.errors.full_messages.each do |error| 
                            flash[:alert] = error
                        end
                    end
                else
                    flash.now[:alert] = "Senha antiga incorreta"
                end
            end
        end
        params[:user] = current_user
    end
end
