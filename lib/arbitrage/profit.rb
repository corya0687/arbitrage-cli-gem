class Arbitrage::Profit
  attr_accessor :nearby_cls, :product, :opportunity,:nearby_products, :market_prices

  def initialize(product)
    self.product = product
    self.nearby_cls = Arbitrage::NearbyCraigslists.new(self.product,self.product.scraper)
    self.opportunity = {}
    self.nearby_products = {}
    self.market_prices = {}
  end

  def list_opportunity
    self.nearby_cls.save_original_url
    puts "Looking for places to sell for a profit at nearby Craiglists"
    self.nearby_cls.save_all_indexes
    puts "Profitable Selling Markets:"
    puts"______________________________________"
    display_market_opportunity
  end

  def display_market_opportunity
    save_opportunity
    compute_avg_market_price
    puts "Below Are markets you should sell your product in to make a profit."
    puts " $$$$$<--Markets-->$$$$$"
    puts puts "------------------------------------------------------"
    display_market_avgs
  end

  def display_market_avgs
    self.market_prices.each_with_index do |(index, value), i|
      puts "#{i+1}.Craiglist Home Page:#{index}"
      puts "Potential Profit:$#{avg_profit(value)}"
      puts "Market Page:#{create_query(index)}"
      puts "------------------------------------------------------"
    end
  end

    def avg_profit(price)
      (price) - (self.product.price.scan(/\d/).join.to_i)
    end


  def compute_avg_market_price
    collect_market_prices
    self.market_prices.each do |index, value|
      avg= value.inject{ |sum, el| sum + el} / value.size
      self.market_prices[index] = avg
    end
  end

  def collect_market_prices
    self.opportunity.each do |key, value|
      self.nearby_cls.all_indexes.detect do |index|
        if value[:url] == index
          if !(self.market_prices[index])
            self.market_prices[index] = []
          else
            self.market_prices[index] << value[:price].scan(/\d/).join.to_i
          end
        end
      end
    end
  end

  def save_opportunity
    products_from_nearby_cls
    self.nearby_products.each do |key, value|
      if profit_margin?(value[:price].scan(/\d/).join.to_i)
        self.opportunity[key] = value
      end
    end
  end

  def profit_margin?(price)
    margin_threshold = 10
    margin = 0
    margin = (price) - (self.product.price.to_i)
    margin > margin_threshold && price > 5
  end

  def products_from_nearby_cls
    q2 = 0
    self.nearby_cls.all_indexes.each_with_index do |index, q|
      counter = 0
      if index != self.nearby_cls.scraper.url
        doc = Nokogiri::HTML(open(create_query(index)))
        doc.css('.row').each_with_index do |row, i|
          if counter < 6
            self.nearby_products["#{q2+1}".to_s] = {
              name: (row.css('.hdrlnk').text),
              price: (row.css('.l2 .price').text),
              url: index
            }
            q2 += 1
            counter +=1
          end
        end
      end
    end
  end

  def create_query(index)
    self.nearby_cls.scraper.craigslist_search_url(index,self.product.query)
  end


end
