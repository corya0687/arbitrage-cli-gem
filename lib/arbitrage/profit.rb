class Arbitrage::Profit
  attr_accessor :nearby_cls, :product

  def initialize(product)
    self.product = product
    self.nearby_cls = Arbitrage::NearbyCraigslists.new(self.product,self.product.scraper)
  end

  def list_opportunities
    self.nearby_cls.next_two_craigslists
    binding.pry
    puts "You gonna make it brah!"
  end

end
