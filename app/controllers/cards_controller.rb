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
    
    def add_card
      carta = CardImporter.getCardByName(params[:card][:wizards_card_code]);
      
      if !carta.present?
        flash[:success] = "Carta não foi encontrada"
        redirect_to url_for(:controller => 'decks', :action => 'edit', :id => params[:card][:deck] )
      else
        @card = Card.new
        @card.wizards_card_code = carta[0]['id']
        @card.edition = carta[0]['editions'][0]['set']
        @card.quantity = 1
        @card.deck_id = params[:card][:deck]
        @card.save
        flash[:success] = "Carta foi adicionada!"
        redirect_to url_for(:controller => 'decks', :action => 'edit', :id => params[:card][:deck] )
      end
    end
end