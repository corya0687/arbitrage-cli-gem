class Arbitrage::Scraper
  attr_accessor :url, :product

  def create_url
  self.url= "http://www.searchtempest.com/search?location=#{self.product.zipcode}&maxDist=25&region_us=1&search_string=#{self.product.name}&keytype=adv&Region=na&cityselect=zip&page=0&category=8&subcat=sss&minAsk=min&maxAsk=max&minYear=min&maxYear=max"
  end

  def scrape_from_search_tempest
    self.url
  end
end
