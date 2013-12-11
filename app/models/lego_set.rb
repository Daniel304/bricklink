class LegoSet
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  require 'nokogiri'
  require 'open-uri'

  attr_accessor :id, :name, :image, :description, :parts, :minifigures, :item_number, :instructions, :release_year, :weight, :dimensions, :link_inventory, :link_priceguide

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def find_set(id)
    doc = Nokogiri::HTML(open('http://www.bricklink.com/catalogItem.asp?S='+ id))
    self.id     = id

    rows = doc.xpath('//center/table[3]/tr/td/table/tr/td/table/tr/td')

    details = rows.collect do |row|
      [                                                                 
        [:name,              "table[2]/tr/td/center/font/b/text()"],
        [:parts,             "table[2]/tr/td/table/tr/td[3]/b[1]/text()"],
        [:minifigures,       "table[2]/tr/td/table/tr/td[3]/b[2]/text()"],
        [:item_number,       "table[3]/tr[1]/td/table[@class='fv']/tr/td[3]/a/text()"],
        [:instructions,      "table[3]/tr[1]/td/table[@class='fv']/tr/td[2]/text()"],
        [:release_year,      "table[3]/tr[1]/td/table[@class='fv']/tr/td[3]/a/text()"],
        [:weight,            "table[3]/tr[1]/td/table[@class='fv']/tr/td[4]/text()"],
        [:dimensions,        "table[3]/tr[1]/td/table[@class='fv']/tr/td[5]/text()"],
        [:link_inventory,    "table[2]/tr/td/table/tr/td[@class='fv']/a/@href"],
        [:link_priceguide,   "table[3]/tr[@class='fv']/td[3]/center/a/@href"],
      ].each do |name, xpath|
        self.send("#{name}=", row.at_xpath(xpath).to_s.strip)
      end

    end
  end

end
