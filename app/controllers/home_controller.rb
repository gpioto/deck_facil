class HomeController < ApplicationController
  def index
    redirect_to :controller => 'users', :action => 'login'
  end
end
