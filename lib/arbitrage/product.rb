class Arbitrage::Product
  attr_accessor :name, :zipcode, :validator, :price, :scraper, :cl_post, :query

  def initialize
    self.scraper = Arbitrage::Scraper.new
    self.scraper.product = self
    self.validator = Arbitrage::InputValidator.new
  end

  def get_product
    puts "Enter the product you intend to sell"
    self.name = gets.chomp
    product_list
    puts "------------------------------------------------------"
    puts "Enter the number of the product you would like to research from the list above"
    choose_product
    show_arbitrage_opportunity
  end

  def choose_product
    choice = gets.chomp
    self.scraper.buy_options.each do |number, hash|
      if choice == number
        self.name = hash[:name]
        self.price = hash[:price]
        self.cl_post = hash[:url]
      end
    end
  end

  def display_product_details
    puts "->Product Title- #{self.name}"
    puts "->Buying Price- #{self.price}"
    puts "->Where to Buy- #{self.cl_post}"
  end

  def product_list
    self.scraper.create_index_url
    self.scraper.create_product_list
  end

  def get_zipcode
    zipcode = gets.chomp
    if !(self.validator.zipcode_valid?(zipcode))
      puts "Invalid zipcode, please enter zipcode"
      get_zipcode
    end
    remove_0_from_zip(zipcode)
  end

  def show_arbitrage_opportunity
    nearby_cls = Arbitrage::NearbyCraigslists.new(self,self.scraper)
  end

  def remove_0_from_zip(zipcode)
    zipcode = zipcode.split("")
    if zipcode.first == "0"
      zipcode.delete_at(0)
      zipcode= zipcode.join
      self.zipcode = zipcode
    else
      zipcode= zipcode.join
    self.zipcode = zipcode
    end
  end

  def user_city_state
    location = ZipCodes.identify(self.zipcode)
    location = "#{location[:city]},#{location[:state_code]}"
  end

end
