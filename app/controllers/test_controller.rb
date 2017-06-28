class TestController < ApplicationController
    
    
    def test
        
    end
    
    def test_byName
        if (params[:card]).present?
            puts "card: " + params[:card][:card]
            card = CardImporter.getCardByName(params[:card][:card])
            flash[:notice] = "Carta encontrada: " + card[0]['name']
        end
    end
    
    def test_byID
        if (params[:card]).present?
            puts "card: " + params[:card][:card]
            card = CardImporter.getCardByID(params[:card][:card])
            flash[:notice] = "Carta encontrada: " + card[0]['name']
        end
    end
end
