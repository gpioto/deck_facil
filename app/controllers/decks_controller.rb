class DecksController < SessionController
    layout 'admin_lte_2'
    def index
      @decks = Deck.where("user_id = ?", current_user.id).select("*")
    end

    def show
      @decks = Deck.find(params[:id])
    end

    def new
      @deck = Deck.new
    end
    
    def create
      @deck = current_user.decks.build
      @deck.name = params[:deck][:name]
      @deck.format = params[:deck][:format]
      @deck.description = params[:deck][:description]
      @deck.save
      flash[:success] = "Deck salvo!"
      redirect_to url_for(:controller => 'decks', :action => 'index')
    end
    
    def edit
      @card = Card.new
    end  
      
end
