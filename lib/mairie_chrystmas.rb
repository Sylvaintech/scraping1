

require 'nokogiri'
require 'csv'
require 'open-uri'




def nom_villes

    doc = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html")) 
    list_villes = []

    doc.css('td > p > a.lientxt').each do |ville|
        list_villes.push(ville.text)
    end

    return list_villes
end
    
    
def lien_villes

    doc = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html")) 
    list_url = []

    doc.xpath('//a[contains(@href,"95")]/@href').each do |lien|
        url_mairie = lien.to_s
        list_url << "http://annuaire-des-mairies.com/" + url_mairie[1, 1000]
    end

    return list_url
end

def couple

    list_villes = nom_villes
    list_url = lien_villes
    courriel = []

    list_url.each do |url_mairie|
        doc = Nokogiri::HTML(URI.open(url_mairie))
        doc.css("body > div > main > section:nth-child(2) > div > table > tbody > tr:nth-child(4) > td:nth-child(2)").each do |mail_mairie|
            if mail_mairie.text == ""
                str = "pas de mail"
                courriel << str
            else
                courriel << mail_mairie.text
            end
        end
    end

    duo = list_villes.zip(courriel).map { |x, y| {x => y} }

    return duo
end

puts couple



def list_val_oise

    page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))
    tab_commune = []

    page.css('td > p > a.lientxt').each do |node|
    puts node.text
    end
puts tab_commune
end


def couple

list_villes = nom_villes
list_url = lien_villes
courriel = []

list_url.each do |url_mairie|
    doc = Nokogiri::HTML(URI.open(url_mairie))
    doc.css("body > div > main > section:nth-child(2) > div > table > tbody > tr:nth-child(4) > td:nth-child(2)").each do |mail_mairie|
        if mail_mairie.text == ""
            str = "pas de mail"
            courriel << str
        else
            courriel << mail_mairie.text
        end
    end
end

duo = list_villes.zip(courriel).map { |x, y| {x => y} }

return duo
end











# def recup_email_mairie
#     page = Nokogiri::HTML(URI.open("https://www.annuaire-des-mairies.com/95/avernes.html"))
#         email = []

#     page.xpath ('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |node|
#     puts node.text
#     end
#     puts email
# end
#  recup_email_mairie