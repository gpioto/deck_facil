class CardsController < SessionController
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
      
      
    end
    
    def addCard
      carta = cardImporter.getCardByName(params[:card][:name]);
      if carta.present?
        flash[:success] = "Carta não encontrada :("
        redirect_to url_for(:controller => 'decks', :action => 'index')
        
        puts "carta nao adicionada"
      else
        @card.wizards_card_code = carta[0]['id']
        @card.edition = carta[0]['editions'][0]['set']
        @card.quantity = 1
        @card.deck_id = 1
        flash[:success] = "Carta adicionada!"
        puts "carta adicionada"
        redirect_to url_for(:controller => 'decks', :action => 'index')
      end
    end
end