class Arbitrage::Product
  attr_accessor :name, :zipcode, :validator, :local_price, :scraper

  def initialize
    self.scraper = Arbitrage::Scraper.new
    self.scraper.product = self
    self.validator = Arbitrage::InputValidator.new
  end

  def get_product
    puts "Enter the product you intend to sell"
    self.name = gets.chomp
    product_list
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
