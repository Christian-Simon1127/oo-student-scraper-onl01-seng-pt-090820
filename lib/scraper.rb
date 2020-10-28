require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    ret_arr = []
    page = Nokogiri::HTML(open(index_url))
    page.css(".student-card").each { |student|
      hash = {}
      hash[:name] = student.css(".student-name").text
      hash[:location] = student.css(".student-location").text
      hash[:profile_url] = student.css("a").attribute("href").value
      ret_arr << hash
    }
    ret_arr
  end

  def self.scrape_profile_page(profile_url)
    hash = {}
    page = Nokogiri::HTML(open(profile_url))
    page.css(".social-icon-container").each { |social|
      placeholder = social.css('a').attribute("href").value.split('/')
      social_key = placeholder[2].split(".com")
      hash[social_key[0].to_sym] = social.css('a').attribute("href").value
    }
    hash[:bio] = 
  end

end

