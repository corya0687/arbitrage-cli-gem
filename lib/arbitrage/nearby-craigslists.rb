class Arbitrage::NearbyCraigslists
  attr_accessor :scraper, :nearby_cls, :original_product

  def initialize(original_product,scraper)
    self.scraper = scraper
    self.nearby_cls = []
    self.original_product = original_product
  end

  def next_two_craigslists
    i=0
    zipcode = self.original_product.zipcode.to_i

    until i == 2
      zipcode += 1
        if !(url_stored?(zipcode))
          self.nearby_cls << find_nearby_url(zipcode)
          i += 1
        end
    end
  end


  def prev_two_craigslists

  end

  def url_stored?(zipcode)
    self.nearby_cls.any? do |current_url|
      current_url == find_nearby_url(zipcode)
    end
  end

  def find_nearby_url(zipcode)
    csv_data = File.read('rsc/clzips.csv')
    rows = csv_data.split("\n")
    people = rows.collect do |row|
      data = row.split(",")
      if data[1].to_i == zipcode
        data[0]
      end

    end
  end
end
