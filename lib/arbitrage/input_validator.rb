class Arbitrage::InputValidator


  def zipcode_valid?(zipcode)
    #stub
    zipcode != zipcode.scan(/./) && zipcode.size == 5
  end


end
