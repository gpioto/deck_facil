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
    
    def destroy
      @card = Card.find_by id: params[:id]
      deck_id = @card.deck_id
       if @card != nil
         @card.destroy
         flash.now[:success] = "Card foi deletado com sucesso"
       else
         flash.now[:error] = "Erro: Card inexistente."
       end
       redirect_to url_for(:controller => 'decks', :action => 'edit', :id => deck_id)
    end
    
    def add_card
      carta = CardImporter.getCardByName(params[:card][:wizards_card_code]);
      
      if !carta.present?
        flash[:success] = "Carta não foi encontrada"
        redirect_to url_for(:controller => 'decks', :action => 'edit', :id => params[:card][:deck] )
      else
        @card = Card.new
        @card.wizards_card_code = carta[0]['name']
        @card.edition = carta[0]['editions'][0]['set']
        @card.quantity = 1
        @card.deck_id = params[:card][:deck]
        @card.save
        flash[:success] = "Carta foi adicionada!"
        redirect_to url_for(:controller => 'decks', :action => 'edit', :id => params[:card][:deck] )
      end
    end
end