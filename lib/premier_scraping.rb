require 'nokogiri'
require 'csv'
require 'open-uri'




def name_crypto
    
    
    page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))
    list_name = []

        page.xpath('//*[@id="__next"]/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr/td[2]/div/a[2]').each do |crypto|
        list_name.push(crypto.text)
        end
   return list_name
end

# print name_crypto



def price_crypto

    page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))
    list_price = []

    page.xpath('//*[@id="__next"]/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/div/a').each do |price|
    list_price.push(price.text)
    end
    return list_price
end

# print price_crypto


def tab_fusion
    list_name = name_crypto
    list_price = price_crypto

    puts list_name.zip(list_price).map { |x, y| {x => y.delete("$,").to_f}}
    
end

def perform
    tab_fusion
end
 perform