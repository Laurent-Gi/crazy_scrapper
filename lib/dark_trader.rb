require 'rubygems'
require 'nokogiri'
require 'open-uri'

# ===============================================================================================
# En prenant pour source le site CoinMarketCap, fait un programme qui récupère le cours de toutes
# les cryptomonnaies et les enregistre bien proprement dans un array de hashs.
# Avec le format suivant :
# a = [  { "BTC" => 5245.12 },
#        { "ETH" => 217.34 }, 
#        etc... ]
# ===============================================================================================

URL='https://coinmarketcap.com/all/views/all/'



def crypto_open_file

  # 1/ Ouverture du fichier avec nokogiri et uri.open 
  #    ----------------------------------------------
  return doc_html_crypto = Nokogiri::HTML(URI.open(URL))
  # puts doc_html_crypto.class  # => Nokogiri::HTML::Document

end


def crypto_names(page)

  return page.xpath('//td[@class="cmc-table__cell cmc-table__cell--sortable cmc-table__cell--left cmc-table__cell--sort-by__symbol"]/div')

end

def crypto_values(page)

  return page.xpath('//td[@class="cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price"]/a[contains(@href, "markets")]') # [@class="cmc-link"]

end


# Pour les tests j'ajoute cette fonction pour accéder aux valeurs depuis la key des mini-hash
def value_of_the_crypto_by_name(tab_de_mini_hash, key)
  tab_de_mini_hash.each do | mini_hash |
    return mini_hash[key] if mini_hash[key] != nil
  end
end

# La fonction du scrapper
def crypto_scrapper

  # 1/ Ouverture du fichier avec nokogiri et uri.open 
  #    ----------------------------------------------
  doc_html_crypto = crypto_open_file


  # 2/ On applique des recherches via WPath   Recherches !
  #    ------------------------------------
  # Ceci_est_un_array_d_elements_html = page.xpath('/mettre_ici_le_XPath') 

  puts " Recherche des noms de Crypto : (Symbols) :\n-------------------------------------------"

  crypto_symbols_html = crypto_names(doc_html_crypto)

  puts "\n  Recherche des cours de ces Crypto : \n-------------------------------------"

  crypto_prices_html = crypto_values(doc_html_crypto)

  # On met les noms (symbols) dans un tableau de strings "crypto_symbols"
  crypto_symbols = Array.new
  crypto_symbols_html.each do |symbols_link|
    crypto_symbols << symbols_link.text 
    print "."
  end
  puts 

  crypto_prices = Array.new
  crypto_prices_html.each do |prices_link|
    crypto_prices << prices_link.text.gsub(/[$,]/,'').to_f
    print "."
  end
  puts

  # Au cas où il n'y ait pas autant de names que de symbols
  #
  return nil if (crypto_prices.size != crypto_symbols.size)

  #Initialisation d'un Hash  et hash_crypto_currencies['crypto_symbols'] = crypto_prices
  # sinon : # hash_crypto_currencies = [crypto_symbols, crypto_prices].transpose.to_h
  hash_crypto_currencies = Hash.new
  hash_crypto_currencies = Hash[crypto_symbols.zip crypto_prices]


  # 3/ Mise en forme finales : Faire un array de plusieurs mini-Hash
  # -----------------------------------------------------------------
  crypto_currencies = Array.new

  hash_crypto_currencies.each do | key, value |
    crypto_currencies << { key => value }
  end


  # 4/ Return de l'objet créé
  # -------------------------
  crypto_currencies.class
  return crypto_currencies

end


def dark_trader

  puts "Bienvenue sur CRYPTO SCRAPPER !\n\n"
  # Appel à la méthode pour scrapper la page HTML des cours de crytomonnaies
  tab_de_hash = crypto_scrapper

end


# Lancement du programme principal :
dark_trader

