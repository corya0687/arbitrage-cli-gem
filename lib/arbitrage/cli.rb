#CLI Controller
class Arbitrage::CLI
  attr_accessor :zipcode, :validator

  def initialize
    self.validator = Arbitrage::InputValidator.new
  end

  def call
    puts "What's your zipcode?"
    get_zipcode
    puts "Thank you, looking for Arbitrage opportunities in #{user_city_state}"
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
