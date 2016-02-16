class Arbitrage::Profit
  attr_accessor :nearby_cls, :product, :opportunity,:nearby_products

  def initialize(product)
    self.product = product
    self.nearby_cls = Arbitrage::NearbyCraigslists.new(self.product,self.product.scraper)
    self.opportunity = []
    self.nearby_products = {}
  end

  def list_opportunity
    self.nearby_cls.save_original_url
    self.nearby_cls.save_all_indexes
    display_opportunity
  end

  def display_opportunity
    save_opportunity
    self.opportunity.each do |key, value|
      puts "#{key[:name]} for #{key[:price]}"
    end
  end

  def save_opportunity
    products_from_nearby_cls
    self.nearby_products.each do |key, value|

      if profit_margin?(value[:price].scan(/\d/).join.to_i)
        self.opportunity << value
      end
    end
  end

  def profit_margin?(price)
    margin_threshold = 10
    margin = 0
    margin = (price) - (self.product.price.to_i)
    margin > margin_threshold
  end

  def products_from_nearby_cls
    self.nearby_cls.all_indexes.each_with_index do |index, q|

      counter = 0
      if index != self.nearby_cls.scraper.url
        doc = Nokogiri::HTML(open(create_query(index)))
        
        doc.css('.row').each_with_index do |row, i|
          if counter < 6
            self.nearby_products["#{i+1}".to_s] = {
              name: (row.css('.hdrlnk').text),
              price: (row.css('.l2 .price').text),
              url:"#{index}mod/#{(row.css('.pl a')[0]['data-id'])}.html"
            }
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
