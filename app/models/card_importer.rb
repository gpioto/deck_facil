require 'open-uri'
require 'ostruct'
require 'json'
class CardImporter
    @domain = "https://api.deckbrew.com/mtg/cards"
    
    
    def self.getCardPicByID(cardId)
        card_info = self.getCardByName(cardId)  
        if !card_info[0].nil? and !card_info[0]['editions'].nil?
            return card_info[0]['editions'][0]['image_url']
        else
            return nil
        end
    end

    # => Entrada: ID da carta
    #
    # => Saida: Carta correspondente ou nil (caso carta não encontrada)
    # => Para acessar cada variavel do objeto utilize: obj['Nome_Do_Campo']
    # => Os campos disponiveis sao os listados nesse exemplo: 
    # => https://api.deckbrew.com/mtg/cards?name=%22Mogis,%20God%20of%20Slaughter%22
    def self.getCardByID(cardId)
        begin
            response = open(@domain+'/'+cardId).read
            obj = JSON.parse(response)
            if obj.present?
                puts obj
                puts 'ID: '+obj['name']
            end
        rescue OpenURI::HTTPError => ex
            obj = nil
            puts "Card not Found"
        end 
        return obj
    end
    
    # => Entrada: Parte do nome da carta
    #
    # => Saida: Array de cartas correspondentes
    # => Para acessar cada variavel do objeto utilize: obj[i]['Nome_Do_Campo']
    # => Os campos disponiveis sao os listados nesse exemplo: 
    # => https://api.deckbrew.com/mtg/cards?name=%22Mogis,%20God%20of%20Slaughter%22
    def self.getCardByName(cardName)
        response = open(@domain+'?name='+cardName).read
        obj = JSON.parse(response)
        if obj.present?
            puts obj[0]
            puts 'Name: '+obj[0]['name']
        end
        
        return obj
    end
    
end