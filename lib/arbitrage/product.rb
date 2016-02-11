class Arbitrage::Product
  attr_accessor :name, :local_price

  def get_product_manually
    puts "Enter the product you intend to sell"
    self.name = gets.chomp
    puts "How much did you or will you pay for this product "
    self.local_price= gets.chomp.to_i
  end

  def create_product_from_local_market


  end

end
