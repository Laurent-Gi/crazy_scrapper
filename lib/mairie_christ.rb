require 'rubygems'
require 'open-uri'
require 'nokogiri'

URL = "http://annuaire-des-mairies.com/val-d-oise.html"

#-----------------------------------------------------------------------------------------------
# On doit récupérer les adresses e-mails des mairies du Val d'Oise, et les mettre dans un Array
#  
# a = [  { "ville_1" => "email_1" },
#        { "ville_2" => "email_2" }, ]
# 
# 2 méthodes proposées : get_townhall_urls 
#                        get_townhall_email(townhall_url)
#-----------------------------------------------------------------------------------------------


# 1/ Récupérer les adresses URL de toutes les villes :
# ----------------------------------------------------
def get_townhall_urls
  # --------------------------------------------------------------
  # On va reconstituer les adresses emails des différentes mairies
  # --------------------------------------------------------------
  doc_html_townhall_all = Nokogiri::HTML(URI.open(URL))  #.xpath('//a[@class="lientxt"]/@href')

  # D'abord, je retraite avec les noms de villes :
  # ----------------------------------------------
  doc_html_cities = doc_html_townhall_all.xpath('//a[@class="lientxt"]')

  # Puis avec directement les emails (champs href)
  doc_html_townhall_all = doc_html_townhall_all.xpath('//a[@class="lientxt"]/@href')

  townhall_urls = Array.new
  doc_html_townhall_all.each do |ligne |
    #                                     On rajoute le chemin commun à tous les sites des mairies
    townhall_urls << "https://www.annuaire-des-mairies.com" + ligne.text[1..-1]  # Retire le . du premier caractère
  end

  townhall_cities = Array.new
  # écrire les villes dans un tableau
  doc_html_cities.each do | city |
    townhall_cities << city.text
  end

  return [ townhall_urls, townhall_cities ]
end


# 2/ Obtenir les emails de toutes les mairies !
# --------------------------------------------
def get_townhall_email(townhalls_urls_and_cities)

  return nil if townhalls_urls_and_cities.nil? || townhalls_urls_and_cities.empty?
  # return nil if list_townhall_urls.nil? || list_townhall_urls.empty? || list_cities.empty? || list_cities.nil?

  # Pour une meilleur compréhension
  list_townhall_urls = townhalls_urls_and_cities[0]
  list_cities = townhalls_urls_and_cities[1]


  #2/Liste des emails--------------------je fais une recherche sur tout... qui contient du text et @ (email ;o)! ) 
  list_townhall_email=Array.new

  list_townhall_email = list_townhall_urls.each{ |url_hall|

    # Lecture d'une page html url_hall (de la ville) pour chaque mairie
    Nokogiri::HTML(URI.open(url_hall)).xpath('//*[contains(text(), "@")]').text
  }
  
  # -=-=-=- Init d'un Array (tableau de hash, conformément au format demandé) -=-=-=-
  # -=-=-=-  MISE EN FORME                                                    -=-=-=-
  townhall_and_email_tab = Array.new

  # for i in 0..cities.length-1 do 
  (0..list_cities.length-1).each do | i |
    townhall_and_email_tab[i] = Hash.new
    townhall_and_email_tab[i][list_cities[i]] = list_townhall_email[i]
  end
  
  return townhall_and_email_tab
end


def mairie_chritsmas

  puts "Bienvenue sur MAIRIE CHRISTMAS !\n\n"

  # Appel de toutes les villes et récupération des sites
  townhalls_datas = get_townhall_urls

  #Scrappons maintenant les sites de chaque mairie pour y récupérer les adresses mail
  return get_townhall_email(townhalls_datas)

end

# Appel à la méthode pour scrapper les pages HTML des annuaires de mairies

mairie_chritsmas

#puts mairie_chritsmas.to_s