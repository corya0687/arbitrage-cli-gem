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
    html = open(craigslist_search_url(self.url,craigslist_query))
    doc = Nokogiri::HTML(html)
    buy_options_menu(doc)
    display_buy_options
  end

  def buy_options_menu(doc)
    self.buy_options = {}
    doc.css('.row').each_with_index do |row, i|
      if i < 11
        self.buy_options["#{i+1}".to_s] = {
          name: (row.css('.hdrlnk').text),
          price: (row.css('.l2 .price').text),
          url:"#{self.url}mod/#{(row.css('.pl a')[0]['data-id'])}.html"
        }
      end
    end
  end

  def display_buy_options
      self.buy_options.each do |key, value|
        puts "#{key}.#{value[:name]} for #{value[:price]}"
      end
  end

  def craigslist_query
    query = self.product.name.split(" ")
    if query.size > 1
      query= query.join("%20")
    else
      query= query.join
    end
    self.product.query = query
  end

  def craigslist_search_url(url,query)
    "#{url}search/sss?query=#{query}&sort=rel"
  end

end
