class Arbitrage::Scraper
  attr_accessor :url, :product, :buy_options

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

  def create_product_list
    craigslist_search_url
    html = open(self.url)
    doc = Nokogiri::HTML(html)
    buy_options_menu(doc)

  end

  def buy_options_menu(doc)
    self.buy_options = {}
    doc.css('.row').each_with_index do |row, i|
      if i < 11
        self.buy_options["#{i+1}".to_s] = {
          name: (row.css('.hdrlnk').text),
          price: (row.css('.l2 .price').text)
        }
        binding.pry
      end
    end
  end

  def craigslist_query
    query = self.product.name.split(" ")
    if query.size > 1
      query= query.join("%20")
    else
      query= query.join
    end
  end

  def craigslist_search_url
    #binding.pry
    self.url = "#{self.url}search/sss?query=#{craigslist_query}&sort=rel"
  end





end
