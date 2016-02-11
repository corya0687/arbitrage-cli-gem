#CLI Controller
class Arbitrage::CLI
  attr_accessor :zipcode, :validator, :local_price, :market_value, :product

  def initialize
    self.validator = Arbitrage::InputValidator.new
    self.product = Arbitrage::Product.new
  end

  def call
    puts "What's your zipcode?"
    get_zipcode
    self.product.get_product_manually
    puts "your potential profit on the sale of #{self.name} is $#{gross_profit}"
  end

  def gross_profit
  #stub
    self.market_value = 330
    binding.pry
    self.market_value - self.product.local_price
  end


  def get_zipcode
    zipcode = gets.chomp
    if !(self.validator.zipcode_valid?(zipcode))
      puts "Invalid zipcode, please enter zipcode"
      get_zipcode
    end
    self.zipcode = zipcode
  end

  def user_city_state
    location = ZipCodes.identify(self.zipcode)
    location = "#{location[:city]},#{location[:state_code]}"
  end
end
