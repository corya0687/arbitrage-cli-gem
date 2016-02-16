class Arbitrage::NearbyCraigslists
  attr_accessor :scraper, :all_indexes, :original_product

  def initialize(original_product,scraper)
    self.scraper = scraper
    self.all_indexes = []
    self.original_product = original_product
  end

  def save_original_url
    self.all_indexes << self.scraper.url
  end

  def save_all_indexes
    next_two_craigslists
    prev_two_craigslists
  end

  def next_two_craigslists
    i=0
    zipcode = self.original_product.zipcode.to_i
    until i == 2
      zipcode += 1
      if !(url_stored?(zipcode)) && find_nearby_url(zipcode) != ""
          self.all_indexes << find_nearby_url(zipcode)
          i += 1
      end
    end
  end


  def prev_two_craigslists
    i=0
    zipcode = self.original_product.zipcode.to_i
    until i == 2
      zipcode -= 1
      if !(url_stored?(zipcode)) && find_nearby_url(zipcode) != ""
          self.all_indexes << find_nearby_url(zipcode)
          i += 1
      end
    end
  end

  def url_stored?(zipcode)
    self.all_indexes.any? do |current_url|
      current_url == find_nearby_url(zipcode)
    end
  end

  def find_nearby_url(zipcode)
    nearby_url = ""
    csv_data = File.read('rsc/clzips.csv')
    rows = csv_data.split("\n")
    people = rows.collect do |row|
      data = row.split(",")
      if data[1].to_i == zipcode
        nearby_url= data[0]
      end
    end
    nearby_url
  end
end
