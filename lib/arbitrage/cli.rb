#CLI Controller
class Arbitrage::CLI
  attr_accessor :validator, :market_value, :product

  def initialize
    self.validator = Arbitrage::InputValidator.new
    self.product = Arbitrage::Product.new
  end

  def call
    puts "What's your zipcode?"
    self.product.get_zipcode
    self.product.get_product
    puts "your potential profit on the sale of #{self.product.name} is $#{gross_profit}"
  end

  def gross_profit
  #stub
    self.market_value = 330
    self.market_value - 200
  end

end
