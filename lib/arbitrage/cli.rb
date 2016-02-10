#CLI Controller
class Arbitrage::CLI

  def call
    puts "What's your zipcode?"
    zipcode= gets.chomp
    binding.pry
  end
end
