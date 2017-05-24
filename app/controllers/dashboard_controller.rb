class DashboardController < SessionController
  layout 'admin_lte_2'

  def dashboard
    @user = current_user
    puts @user
  end

end
