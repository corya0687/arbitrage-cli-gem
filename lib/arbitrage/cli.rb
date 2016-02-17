#CLI Controller
class Arbitrage::CLI
  attr_accessor :validator, :market_value, :product, :profit

  def initialize
    self.validator = Arbitrage::InputValidator.new
    self.product = Arbitrage::Product.new
    self.profit = Arbitrage::Profit.new(self.product)
  end

  def call
    puts "What's your zipcode?"
    self.product.get_zipcode
    self.product.get_product
    puts "Details on the product you've selected:"
    puts "______________________________________"
    puts self.product.display_product_details
    puts "______________________________________"
    self.profit.list_opportunity
    #puts "your potential profit on the sale of #{self.product.name} is $#{gross_profit}"
  end


end
