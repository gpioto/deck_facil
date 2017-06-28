class DecksController < SessionController
    layout 'admin_lte_2'
    def index
      @decks = Deck.all.order("created_at DESC")
    end

    def show
      @decks = Deck.find(params[:id])
    end

    def new
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
      @deck = @current_user.decks.build
    end
    
    def create
      @deck.save
    end
end
