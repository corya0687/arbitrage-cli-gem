class Arbitrage::Scraper
  attr_accessor :url, :product

  def create_index_url
    csv_data = File.read('rsc/clzips.csv')
    rows = csv_data.split("\n")
    people = rows.collect do |row|
      data = row.split(",")
      if data[1] == self.product.zipcode
        self.url=data[0]
      end

    end
  end

  def craigslist_search_url

  end


  def create_product_list
    html = open(self.url)
    doc = Nokogiri::HTML(html)
    binding.pry
  end


end
